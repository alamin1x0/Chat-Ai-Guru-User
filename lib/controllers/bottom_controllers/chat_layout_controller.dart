import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:probot/bot_api/api_services.dart';
import 'package:probot/screens/bottom_screens/chat_layout/layouts/suggestion_list.dart';
import 'package:probot/models/quiestions_suggestion_model.dart';
import '../../config.dart';

class ChatLayoutController extends GetxController
    with GetSingleTickerProviderStateMixin {
  dynamic data;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int index = 0;
  int selectIndex = 0;
  bool isLongPress = false;
  List backgroundList = [];
  List questionsSuggestionList = [];
  List questionsLists = [];
  Rx<List<ChatListDateWise>> chatList = Rx<List<ChatListDateWise>>([]);
  final chatController = TextEditingController();
  ScrollController scrollController = ScrollController();
  String? time, argImage;
  List selectedIndex = [];
  List selectedData = [];
  DateTime? receiverTime;
  AnimationController? animationController;
  Animation? animation;
  String? chatId;
  bool isRewardedAdLoaded = false;
  FocusNode focusNode = FocusNode();
  int count = 0;
  int receiverCount = 0;
  int lastIndex = 0;
  int receiverLastIndex = 0;
  dynamic selectedImage;
  SpeechToText speech = SpeechToText();
  Rx<List<ChatMessage>> messages = Rx<List<ChatMessage>>([]);
  Rx<bool> isLoading = Rx<bool>(false);
  final FlutterTts? flutterTts = FlutterTts();
  final _isSpeech = false.obs;
  final isListening = false.obs;
  ScreenshotController screenshotController = ScreenshotController();
  List<String> shareMessages = ['--THIS IS CONVERSATION with AiGuru--\n\n'];
  List<String> selectedMessages = [];
  RxInt itemCount = 0.obs;
  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );
  RxString textInput = ''.obs;
  final _isSpeechLoading = false.obs;
  bool isInterstitialAdLoaded = false;
  RxInt chatCount = 0.obs;
  RxString userInput = "".obs;
  RxString result = "".obs;
  static const interstitialButtonText = 'InterstitialAd';
  static const rewardedButtonText = 'RewardedAd';
  static const rewardedInterstitialButtonText = 'RewardedInterstitialAd';
  static const fluidButtonText = 'Fluid';
  static const inlineAdaptiveButtonText = 'Inline adaptive';
  static const anchoredAdaptiveButtonText = 'Anchored adaptive';
  static const nativeTemplateButtonText = 'Native template';

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  BannerAd? bannerAd;
  bool bannerAdIsLoaded = false;

  onSuggestionChange(data) {
    selectIndex = data["id"];
    update();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    /*var imageData = Get.arguments;
    log("=+========+++++++=$imageData");*/
    /*log("-----------------------------${Get.arguments}");
    log("++++++++++++++++++++++++++++++${Get.arguments["recText"].toString()}");
    chatController.text = Get.arguments["recText"].toString();
    log("******************************${chatController.text}");
    chatController.addListener(() {update();});*/
    questionsSuggestionList = appArray.questionSuggestionList;
    questionsLists = appArray.questionsList
        .map((e) => QuestionSuggestionsModel.fromJson(e))
        .toList();
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: Platform.isAndroid
            ? appCtrl.firebaseConfigModel!.bannerAddId!
            : appCtrl.firebaseConfigModel!.bannerIOSId!,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            log('$BannerAd loaded.');
            bannerAdIsLoaded = true;
            update();
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            log('$BannerAd failedToLoad: $error');
            ad.dispose();
          },
          onAdOpened: (Ad ad) => log('$BannerAd onAdOpened.'),
          onAdClosed: (Ad ad) => log('$BannerAd onAdClosed.'),
        ),
        request: const AdRequest())
      ..load();
    log("bannerAd : $bannerAd");

    _getId().then((id) {
      String? deviceId = id;

      FacebookAudienceNetwork.init(
        testingId: deviceId,
        iOSAdvertiserTrackingEnabled: true,
      );
    });
    _showBannerAd();

    data = appCtrl.storage.read(session.selectedCharacter);

    backgroundList = appArray.backgroundList;
    selectedImage =
        appCtrl.storage.read("backgroundImage") ?? appArray.backgroundList[0];
    speech = SpeechToText();
    update();
    log("chatList : $chatId");
    if (appCtrl.firebaseConfigModel!.isAddShow! &&
        appCtrl.envConfig["chatTextCount"] != "unlimited") {
      _createInterstitialAd();
    }
    loadInterstitialAd();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animationController!.repeat(reverse: true);
    animation = Tween(begin: 15.0, end: 24.0).animate(animationController!)
      ..addListener(() {
        update();
      });
    update();
    super.onReady();
  }

  //clear data while go back
  clearData() async {
    if (messages.value.length == 1) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("chats")
          .where("chatId", isEqualTo: chatId)
          .limit(1)
          .get()
          .then((value) {
        log("ISDAA : ${value.docs[0].exists}");
        if (value.docs[0].exists) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("chats")
              .doc(value.docs[0].id)
              .delete()
              .then((value) async {
            await FirebaseFirestore.instance
                .collection("chatHistory")
                .doc(chatId)
                .delete();
          });
        }
      });
    }

    speechStopMethod();
    isLongPress = false;
    selectedData = [];
    selectedIndex = [];
    messages = Rx<List<ChatMessage>>([]);
    shareMessages = [];
    itemCount = 0.obs;
    update();
  }

  @override
  void onClose() {
    animationController!.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
    animationController!.dispose();
    _interstitialAd?.dispose();
    bannerAd?.dispose();
    bannerAd = null;
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // Unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // Unique ID on Android
    }
  }

  _showBannerAd() {
    log("SHOW BANNER");
    currentAd = FacebookBannerAd(
      // placementId: "YOUR_PLACEMENT_ID",
      placementId: appCtrl.firebaseConfigModel!.facebookAddAndroidId!,
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        log("Banner Ad: $result -->  $value");
      },
    );
    update();
    log("_currentAd : $currentAd");
  }

  void loadInterstitialAd() {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: appCtrl.firebaseConfigModel!.facebookInterstitialAd!,
      listener: (result, value) {
        log("result : $result");
        log("result1 : ${result.name}");
        log("result2 : $value");
        if (result == InterstitialAdResult.LOADED) {
          FacebookInterstitialAd.showInterstitialAd(delay: 5000);
        }
      },
    );
  }

  showFbInterstitialAd() {
    if (isInterstitialAdLoaded == true) {
      FacebookInterstitialAd.showInterstitialAd();
    } else {
      log("Interstial Ad not yet loaded!");
    }
  }

  //initialize interstitial add
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? appCtrl.firebaseConfigModel!.interstitialAdIdAndroid!
            : appCtrl.firebaseConfigModel!.interstitialAdIdIOS!,
        request: appCtrl.request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            log('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            log('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < 3) {
              _createInterstitialAd();
            }
          },
        ));
    update();
    appCtrl.createRewardedAd();
  }

  //show interstitial add
  void showInterstitialAd() {
    if (_interstitialAd == null) {
      log('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          log('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
    update();
  }

  //speech method
  speechMethod(String text, String language) async {
    _isSpeechLoading.value = true;
    _isSpeech.value = true;
    update();

    await flutterTts!.setLanguage(language);
    await flutterTts!.setPitch(1);
    await flutterTts!.setSpeechRate(0.45);
    await flutterTts!.speak(text);

    Future.delayed(
        const Duration(seconds: 2), () => _isSpeechLoading.value = false);
    update();
  }

  //stop speech method
  speechStopMethod() async {
    _isSpeech.value = false;
    await flutterTts!.stop();
    update();
  }

  //scroll direction
  void scrollDown() {
    if(scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  //add text count
  addTextCount() async {
    debugPrint("-------${chatCount.value.toString()}--------");
    chatCount.value++;
    // LocalStorage.saveTextCount(count: chatCount.value);
  }

  getChatId() {
    int createdDate = DateTime.now().millisecondsSinceEpoch;
    bool isGuestLogin = appCtrl.storage.read(session.isGuestLogin);
    selectedImage =
        appCtrl.storage.read("backgroundImage") ?? appArray.backgroundList[0];
    if (Get.arguments != null) {
      chatId = Get.arguments["chatId"] ??
          DateTime.now().millisecondsSinceEpoch.toString();
      log("RICHTEXT : ${Get.arguments}");
      argImage = Get.arguments["avatar"] ?? appCtrl.selectedCharacter["image"];
      log("ARGS$argImage");
      update();
      if (Get.arguments["recText"] != null) {
        chatController.text = Get.arguments["recText"];
        update();
        processChat();
      } else if (Get.arguments["speechText"] != null) {
        update();
        processChat();
      } else {
        log("NO IMAGE FOUND");
        if (Get.arguments["avatar"].contains("assets")) {
          argImage = appCtrl.selectedCharacter["image"];
        } else {
          argImage =
              Get.arguments["avatar"] ?? appCtrl.selectedCharacter["image"];
        }
      }
      log("ARG : ${Get.arguments["avatar"]}");
      if (Get.arguments["avatar"].contains("assets")) {
        argImage = appCtrl.selectedCharacter["image"];
        log("ARG : $argImage}");
      } else {
        argImage =
            Get.arguments["avatar"] ?? appCtrl.selectedCharacter["image"];
      }
      log("argImage : $argImage");
      update();
    } else {
      log("MESSAGE : ${appCtrl.selectedCharacter}");

      argImage = appCtrl.selectedCharacter["image"];
      messages.value.add(
        ChatMessage(
            text: appCtrl.selectedCharacter["message"],
            chatMessageType: ChatMessageType.bot,
            time: DateTime.now().millisecondsSinceEpoch),
      );
      shareMessages
          .add("${appCtrl.selectedCharacter["message"]} - By AiGuru\n");
      selectedMessages
          .add("${appCtrl.selectedCharacter["message"]} - By AiGuru\n");
      itemCount.value = messages.value.length;

      update();
      chatId = DateTime.now().millisecondsSinceEpoch.toString();

      if (!isGuestLogin) {
        log("chatId : $chatId");
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("chats")
            .where("chatId", isEqualTo: chatId)
            .limit(1)
            .get()
            .then((valueCheck) async {
          if (valueCheck.docs.isEmpty) {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("chats")
                .add({
              'userId': FirebaseAuth.instance.currentUser!.uid,
              'avatar': appCtrl.selectedCharacter["image"],
              "characterId": appCtrl.selectedCharacter["id"],
              'message': appCtrl.selectedCharacter["message"],
              'chatId': chatId,
              "createdDate": createdDate,
            }).then((add) async {
              await FirebaseFirestore.instance
                  .collection("chatHistory")
                  .doc(chatId)
                  .collection("chats")
                  .add({
                'userId': FirebaseAuth.instance.currentUser!.uid,
                'avatar': appCtrl.selectedCharacter["image"],
                "characterId": appCtrl.selectedCharacter["id"],
                'message': appCtrl.selectedCharacter["message"],
                'chatId': chatId,
                "createdDate": createdDate,
                "messageType": ChatMessageType.bot.name
              });
            });
          } else {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("chats")
                .doc(valueCheck.docs[0].id)
                .update({
              'userId': FirebaseAuth.instance.currentUser!.uid,
              'avatar': appCtrl.selectedCharacter["image"],
              'message': appCtrl.selectedCharacter["message"],
              'chatId': chatId,
              "createdDate": createdDate,
            }).then((values) async {
              await FirebaseFirestore.instance
                  .collection("chatHistory")
                  .doc(chatId)
                  .collection("chats")
                  .add({
                'userId': FirebaseAuth.instance.currentUser!.uid,
                'avatar': appCtrl.selectedCharacter["image"],
                'message': appCtrl.selectedCharacter["message"],
                'chatId': chatId,
                "createdDate": createdDate,
                "messageType": ChatMessageType.bot.name
              });
            });
          }
        });
      }
    }
    update();
  }

  //process for chat
  processChat() async {
    int createdDate = DateTime.now().millisecondsSinceEpoch;
    //chat, image and text completion count as per subscription or not
    appCtrl.update();
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    speechStopMethod();
    addTextCount();
    log("CONFIG L:${appCtrl.envConfig}");
    // add this data for guest
    messages.value.add(
      ChatMessage(
          text: chatController.text,
          chatMessageType: ChatMessageType.user,
          time: DateTime.now().millisecondsSinceEpoch),
    );
    shareMessages.add("${chatController.text} - Myself\n");
    selectedMessages.add("${chatController.text} - Myself\n");
    itemCount.value = messages.value.length;
    update();
    Get.forceAppUpdate();
    log("chatCount1 : ${appCtrl.envConfig}");
    int i = messages.value.indexWhere(
        (element) => element.chatMessageType == ChatMessageType.loading);
    bool isGuestLogin = appCtrl.storage.read(session.isGuestLogin);

    log("isGuestLogin : $isGuestLogin");
    if (i < 0) {
      Future.delayed(const Duration(milliseconds: 5));
      log("i : $i");
      messages.value.add(
        ChatMessage(
            text: "",
            chatMessageType: ChatMessageType.loading,
            time: DateTime.now().millisecondsSinceEpoch),
      );

      itemCount.value = messages.value.length;
      update();
    }

    //store data in firebase
    textInput.value = chatController.text;
    if (!isGuestLogin) {
      log("chatId : $chatId");
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("chats")
          .where("chatId", isEqualTo: chatId)
          .limit(1)
          .get()
          .then((valueCheck) async {
        if (valueCheck.docs.isEmpty) {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("chats")
              .add({
            'userId': FirebaseAuth.instance.currentUser!.uid,
            'avatar': appCtrl.selectedCharacter["image"],
            "characterId": appCtrl.selectedCharacter["id"],
            'message': textInput.value,
            'chatId': chatId,
            "createdDate": createdDate,
          }).then((add) async {
            await FirebaseFirestore.instance
                .collection("chatHistory")
                .doc(chatId)
                .collection("chats")
                .add({
              'userId': FirebaseAuth.instance.currentUser!.uid,
              'avatar': appCtrl.selectedCharacter["image"],
              "characterId": appCtrl.selectedCharacter["id"],
              'message': textInput.value,
              'chatId': chatId,
              "createdDate": createdDate,
              "messageType": ChatMessageType.user.name
            }).then((values) async {
              await deleteLoading();
            });
          });
        } else {
          await FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("chats")
              .doc(valueCheck.docs[0].id)
              .update({
            'userId': FirebaseAuth.instance.currentUser!.uid,
            'avatar': appCtrl.selectedCharacter["image"],
            'message': textInput.value,
            'chatId': chatId,
            "createdDate": createdDate,
          }).then((values) async {
            await FirebaseFirestore.instance
                .collection("chatHistory")
                .doc(chatId)
                .collection("chats")
                .add({
              'userId': FirebaseAuth.instance.currentUser!.uid,
              'avatar': appCtrl.selectedCharacter["image"],
              'message': textInput.value,
              'chatId': chatId,
              "createdDate": createdDate,
              "messageType": ChatMessageType.user.name
            }).then((addVal) async {
              await deleteLoading();
            });
          });
        }
      });
    }

    update();
    chatController.clear();
    scrollDown();
    update();
    await Future.delayed(const Duration(milliseconds: 3));
    ApiServices.chatCompeletionResponse(textInput.value).then((value) async {
      log("RESPONSE : $value");
      if (value == "") {
        if (!isGuestLogin) {
          await FirebaseFirestore.instance
              .collection("chatHistory")
              .doc(chatId)
              .collection("chats")
              .where("messageType", isEqualTo: ChatMessageType.loading.name)
              .limit(1)
              .get()
              .then((loadVal) {
            if (loadVal.docs.isNotEmpty) {
              log("LOAD DATA : ${loadVal.docs[0].id}");
              FirebaseFirestore.instance
                  .collection("chatHistory")
                  .doc(chatId)
                  .collection("chats")
                  .doc(loadVal.docs[0].id)
                  .delete();
            }
          });
        }
      } else {
        // isLoading.value = false
        log("valuevalue : $value");
        messages.value.removeWhere(
            (element) => element.chatMessageType == ChatMessageType.loading);

        messages.value.add(
          ChatMessage(
              text: value.replaceFirst("\n", " ").replaceFirst("\n", " "),
              chatMessageType: ChatMessageType.bot,
              time: DateTime.now().millisecondsSinceEpoch),
        );

        itemCount.value = messages.value.length;
        update();
        shareMessages.add(
            "${value.replaceFirst("\n", " ").replaceFirst("\n", " ")} -By AiGuru\n");
        selectedMessages.add(
            "${value.replaceFirst("\n", " ").replaceFirst("\n", " ")} -By AiGuru\n");

        scrollDown();
        isLoading.value = false;
        if (!isGuestLogin) {
          FirebaseFirestore.instance
              .collection("chatHistory")
              .doc(chatId)
              .collection("chats")
              .where("messageType", isEqualTo: ChatMessageType.loading.name)
              .limit(1)
              .get()
              .then((loadVal) {
            log("LOAD DATA : ${loadVal.docs[0]}");
            if (loadVal.docs.isNotEmpty) {
              FirebaseFirestore.instance
                  .collection("chatHistory")
                  .doc(chatId)
                  .collection("chats")
                  .doc(loadVal.docs[0].id)
                  .delete()
                  .then((res) {
                FirebaseFirestore.instance
                    .collection("chatHistory")
                    .doc(chatId)
                    .collection("chats")
                    .add({
                  'userId': FirebaseAuth.instance.currentUser!.uid,
                  'avatar': appCtrl.selectedCharacter["image"],
                  "characterId": appCtrl.selectedCharacter["id"],
                  'message':
                      value.replaceFirst("\n", " ").replaceFirst("\n", " "),
                  'chatId': chatId,
                  "createdDate": DateTime.now().millisecondsSinceEpoch,
                  "messageType": ChatMessageType.bot.name
                });
              });
            }
          });
        }
      }

      update();
    });
    scrollDown();
    Get.forceAppUpdate();
    update();
  }

  deleteLoading() async {
    log("DELETE");
    FirebaseFirestore.instance
        .collection("chatHistory")
        .doc(chatId)
        .collection("chats")
        .where("messageType", isEqualTo: ChatMessageType.loading.name)
        .limit(1)
        .get()
        .then((loadVal) {
      if (loadVal.docs.isNotEmpty) {
        log("DELETE1");
        FirebaseFirestore.instance
            .collection("chatHistory")
            .doc(chatId)
            .collection("chats")
            .doc(loadVal.docs[0].id)
            .delete()
            .then((values) {
          FirebaseFirestore.instance
              .collection("chatHistory")
              .doc(chatId)
              .collection("chats")
              .add({
            'userId': FirebaseAuth.instance.currentUser!.uid,
            'avatar': appCtrl.selectedCharacter["image"],
            "characterId": appCtrl.selectedCharacter["id"],
            'message': "",
            'chatId': chatId,
            "createdDate": DateTime.now().millisecondsSinceEpoch,
            "messageType": ChatMessageType.loading.name
          });
        });
      } else {
        log("DELETE2");
        FirebaseFirestore.instance
            .collection("chatHistory")
            .doc(chatId)
            .collection("chats")
            .add({
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'avatar': appCtrl.selectedCharacter["image"],
          "characterId": appCtrl.selectedCharacter["id"],
          'message': "",
          'chatId': chatId,
          "createdDate": DateTime.now().millisecondsSinceEpoch,
          "messageType": ChatMessageType.loading.name
        });
      }
    });
  }

  //pop up menu item
  PopupMenuItem buildPopupMenuItem(
      String title, IconData iconData, int position) {
    return PopupMenuItem(
        value: position,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt)),
          const VSpace(Sizes.s15),
          if (position != 4)
            Divider(height: 0, color: appCtrl.appTheme.greyLight, thickness: 1)
        ]));
  }

  //show share dialog
  showShareDialog() {
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return const Align(
          alignment: Alignment.center,
          child: ShareLayout(),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  //clear chat success
  clearChatSuccessDialog() {
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return const Align(
          alignment: Alignment.center,
          child: ClearChatSuccess(),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  //speech to text
  void speechToText() async {
    speechStopMethod();
    chatController.text = '';
    result.value = '';
    userInput.value = '';
    log("ISLISTEN : ${isListening.value}");
    if (isListening.value == false) {
      bool available = await speech.initialize(
        onStatus: (val) {
          debugPrint('*** onStatus: $val');
          log("loo : ${val == "done"}");
          if (val == "done" || val == "notListening") {
            isListening.value = false;
            update();
          }
          Get.forceAppUpdate();
        },
        onError: (val) {
          debugPrint('### onError: $val');
        },
      );
      log("available ; $available");
      if (available) {
        isListening.value = true;

        speech.listen(
          localeId: appCtrl.languageVal,
          onResult: (val) {
            log("VAL : $val");
            chatController.text = val.recognizedWords.toString();
            userInput.value = val.recognizedWords.toString();
            update();
          },
          cancelOnError: true,
        );

        update();
      } else {
        log("NO");
      }
    } else {
      isListening.value = false;
      speechStopMethod();
      update();
    }
  }

  onTapSuggestions() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<ChatLayoutController>(builder: (_) {
          return const SuggestionList();
        });
      }),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppRadius.r10),
              topLeft: Radius.circular(AppRadius.r10))),
    );
  }

  onTapChat() => chatController.text.isNotEmpty
      ? processChat()
      : Get.snackbar(appFonts.attention.tr, appFonts.enterTextBoxValue.tr);

  onStartSpeech() {
    Vibration.vibrate(duration: 200);
    speechToText();
    update();
  }

  onListClear() {
    isLongPress = false;
    selectedData = [];
    selectedIndex = [];
    update();
  }

  onTapRegenerateResponse() {
    int index = selectedIndex[0];
    chatController.text = messages.value[index].text!;
    processChat();
    isLongPress = false;
    selectedIndex = [];
    update();
  }

  onTapCopy() {
    Clipboard.setData(ClipboardData(text: selectedData.toString()));
    update();
  }

  onTapShare() {
    Share.share(selectedData.toString(),
        subject: "I'm sharing Conversation with AiGuru");
    update();
  }

  onTapRemoveSelectedList() {
    isLongPress = false;
    selectedIndex = [];
    update();
  }

  onTapUnselect() {
    if (isLongPress) {
      if (!selectedIndex.contains(index)) {
       selectedIndex.add(index);
        selectedData
            .add(selectedMessages[index]);
        update();
      } else {
        if (selectedIndex.contains(index)) {
          selectedIndex.remove(index);
          selectedData.remove(
              selectedMessages[index]);
          update();
        }
      }
    }

    if (selectedIndex.isEmpty) {
      isLongPress = false;
      update();
    }
  }

}
