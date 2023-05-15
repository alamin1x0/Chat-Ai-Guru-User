import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:probot/bot_api/api_services.dart';
import '../../config.dart';

class SocialMediaController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController captionController = TextEditingController();
  TextEditingController captionGeneratedController = TextEditingController();
  TextEditingController musicGeneratedController = TextEditingController();
  TextEditingController hashtagController = TextEditingController();
  TextEditingController hashtagGeneratedController = TextEditingController();
  final FixedExtentScrollController? scrollController =
      FixedExtentScrollController();
  final FixedExtentScrollController? categoryScrollController =
      FixedExtentScrollController();
  double progressValue = 0;
  AnimationController? animationController;
  Animation? animation;

  SpeechToText speech = SpeechToText();
  final FlutterTts? flutterTts = FlutterTts();
  final _isSpeech = false.obs;
  final isListening = false.obs;
  final languageCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());
  BannerAd? bannerAd;
  bool bannerAdIsLoaded = false;
  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );

  List socialMediaLists = [];
  List captionCreatorLists = [];
  List captionToneLists = [];
  List musicCategoryList = [];
  int selectedIndex = 0;
  int selectedIndexTone = 0;
  bool isCaptionGenerated = false;
  bool isMusicGenerated = false;
  bool isHashtagGenerated = false;
  bool isLoader = false;
  int value = 0;
  String? selectItem;
  String? onSelect;
  int categoryValue = 0;
  String? categorySelectItem;
  String? categoryOnSelect;
  String? hashtagResponse;
  String? captionResponse;
  String? musicResponse;

  SfRangeValues values = const SfRangeValues(30, 40);

  onClear() {
    captionController.clear();
    musicGeneratedController.clear();
    hashtagController.clear();
    isCaptionGenerated = false;
    isMusicGenerated = false;
    isHashtagGenerated = false;
    isLoader = false;
    textToSpeechCtrl.onStopTTS();
  }

  void updateProgress() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      progressValue += 0.03;
      update();
    });
  }

  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('json_class/genres.json');
    final data = await json.decode(response);
    musicCategoryList = data;
    update();
  }

  onCaptionGenerate() {
    if (captionController.text.isNotEmpty) {
      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
                "Please give me best ${captionToneLists[selectedIndexTone]['title']} caption Suggestion for ${captionCreatorLists[selectedIndex]['title']} platform for ${captionController.text} photo for ${values.start} to ${values.end} age targeted audience")
            .then((value) {
          if (value != "") {
            captionResponse = value;
            isCaptionGenerated = true;
            isLoader = false;
            update();
          } else {
            isLoader = false;
            snackBarMessengers(message: appFonts.somethingWentWrong.tr);
            update();
          }
        });
        update();
      }
    } else {
      Get.snackbar(appFonts.attention.tr, appFonts.enterTextBoxValue.tr);
    }
  }

  //stop speech method
  speechStopMethod() async {
    _isSpeech.value = false;
    await flutterTts!.stop();
    update();
  }

  //speech to text
  void speechToText() async {
    speechStopMethod();
    captionController.text = '';
    hashtagController.text = '';
    musicGeneratedController.text = '';

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
            captionController.text = val.recognizedWords.toString();
            hashtagController.text = val.recognizedWords.toString();
            musicGeneratedController.text = val.recognizedWords.toString();
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

  @override
  void dispose() {
    captionController.clear();
    musicGeneratedController.clear();
    hashtagController.clear();
    textToSpeechCtrl.onStopTTS();
    animationController!.dispose();
    super.dispose();
  }

  onMusicGenerate() {
    int balance = appCtrl.envConfig["balance"];
    if (balance == 0) {
      appCtrl.balanceTopUpDialog();
    } else {
      addCtrl.onInterstitialAdShow();
      isLoader = true;
      ApiServices.chatCompeletionResponse(
              "Please give me music Suggestion ${categorySelectItem ?? "Classic"} category and in ${selectItem ?? "Hindi"} for post")
          .then((value) {
        log("++++++++++++++++======$value");
        if (value != "") {
          musicResponse = value;
          update();
          isMusicGenerated = true;
          isLoader = false;
          update();
        } else {
          isLoader = false;
          snackBarMessengers(message: appFonts.somethingWentWrong.tr);
          update();
        }
      });
      update();
    }
  }

  onCaptionToneChange(index) {
    selectedIndexTone = index;
    update();
  }

  onPlatformChange(index) {
    selectedIndex = index;
    update();
  }

  onGoPage(value) {
    if (value["title"] == appFonts.captionAbout) {
      Get.toNamed(routeName.captionCreatorScreen);
    } else if (value["title"] == appFonts.getMusicSuggestion) {
      Get.toNamed(routeName.musicForPostScreen);
    } else {
      Get.toNamed(routeName.hashtagForPostScreen);
    }
  }

  onHashtagGenerate() {
    if (hashtagController.text.isNotEmpty) {
      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        const oneSec = Duration(seconds: 1);
        Timer.periodic(oneSec, (Timer t) {
          progressValue += 0.03;
          update();
        });
        isLoader = true;
        ApiServices.chatCompeletionResponse(
                "Please give me Hashtag Suggestion for ${hashtagController.text} post")
            .then((value) {
          if (value != "") {
            hashtagResponse = value;
            isHashtagGenerated = true;
            isLoader = false;
            progressValue = 0.0;
            update();
          } else {
            isLoader = false;
            snackBarMessengers(message: appFonts.somethingWentWrong.tr);
            update();
          }
        });
        update();
      }
    } else {
      Get.snackbar(appFonts.attention.tr, appFonts.enterTextBoxValue.tr);
    }
  }

  endCaptionGeneratorDialog() {
    dialogLayout.endDialog(
        title: appFonts.endCaptionGenerator,
        subTitle: appFonts.areYouSureEndCodeGenerator,
        onTap: () {
          captionController.clear();
          textToSpeechCtrl.onStopTTS();
          isCaptionGenerated = false;
          Get.back();
          update();
        });
  }

  onSelectLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: languageCtrl.translateLanguagesList,
            index: value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, languageCtrl.translateLanguagesList);
            },
            scrollController: socialMediaCtrl.scrollController,
            onSuggestionSelected: (i) {
              int index =
                  languageCtrl.translateLanguagesList.indexWhere((element) {
                return element == i;
              });
              socialMediaCtrl.scrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              socialMediaCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = languageCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              socialMediaCtrl.update();
            },
            selectOnTap: () {
              onSelect = selectItem;
              Get.back();
              socialMediaCtrl.update();
            },
          );
        });
      }),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppRadius.r10),
              topLeft: Radius.circular(AppRadius.r10))),
    );
  }

  onSelectMusicCategorySheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
          return LanguagePickerLayout(
            image: eSvgAssets.music,
            title: appFonts.selectMusicCategory,
            list: socialMediaCtrl.musicCategoryList,
            index: socialMediaCtrl.categoryValue,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, socialMediaCtrl.musicCategoryList.cast<String>());
            },
            scrollController: socialMediaCtrl.categoryScrollController,
            onSuggestionSelected: (i) {
              int index =
                  socialMediaCtrl.musicCategoryList.indexWhere((element) {
                return element == i;
              });
              socialMediaCtrl.categoryScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              socialMediaCtrl.update();
            },
            onSelectedItemChanged: (i) {
              socialMediaCtrl.categoryValue = i;
              categorySelectItem = socialMediaCtrl.musicCategoryList[i];
              log("SELECT ITEM: $categorySelectItem");
              update();
              socialMediaCtrl.update();
            },
            selectOnTap: () {
              categoryOnSelect = categorySelectItem;
              Get.back();
              socialMediaCtrl.update();
            },
          );
        });
      }),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppRadius.r10),
              topLeft: Radius.circular(AppRadius.r10))),
    );
  }

  endMusicGeneratorDialog() {
    dialogLayout.endDialog(
        title: appFonts.endMusicGeneration,
        subTitle: appFonts.areYouSureEndMusic,
        onTap: () {
          musicGeneratedController.clear();
          textToSpeechCtrl.onStopTTS();
          isMusicGenerated = false;
          Get.back();
          update();
        });
  }

  endHashtagGeneratorDialog() {
    dialogLayout.endDialog(
        title: appFonts.endHashtagBuilder,
        subTitle: appFonts.areYouSureEndCodeGenerator,
        onTap: () {
          hashtagController.clear();
          isHashtagGenerated = false;
          textToSpeechCtrl.onStopTTS();
          progressValue = 0.0;
          Get.back();
          update();
        });
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
      placementId: Platform.isAndroid
          ? appCtrl.firebaseConfigModel!.facebookAddAndroidId!
          : appCtrl.firebaseConfigModel!.facebookAddIOSId!,
      bannerSize: BannerSize.STANDARD,
      listener: (result, value) {
        log("Banner Ad: $result -->  $value");
      },
    );
    update();
    log("_currentAd : $currentAd");
  }

  buildBanner() async {
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
    log("Home Banner AGAIn: $bannerAd");
  }


  onStopSTT() {
    Vibration.vibrate(duration: 200);
    speechToText();
    update();
  }


  @override
  void onReady() {
    appCtrl.firebaseConfigModel = FirebaseConfigModel.fromJson(
        appCtrl.storage.read(session.firebaseConfig));
    log("BANNER: ${appCtrl.firebaseConfigModel!}");
    if (bannerAd == null) {
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
      log("Home Banner : $bannerAd");
    } else {
      bannerAd!.dispose();
      buildBanner();
    }
    _getId().then((id) {
      String? deviceId = id;
      FacebookAudienceNetwork.init(
        testingId: deviceId,
        iOSAdvertiserTrackingEnabled: true,
      );
    });
    _showBannerAd();

    addCtrl.onInterstitialAdShow();
    readJson();
    captionCreatorLists = appArray.captionCreatorList;
    socialMediaLists = appArray.socialMediaList;
    captionToneLists = appArray.captionToneList;

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animationController!.repeat(reverse: true);
    animation = Tween(begin: 15.0, end: 24.0).animate(animationController!)
      ..addListener(() {
        update();
      });
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
