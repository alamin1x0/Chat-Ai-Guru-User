import 'dart:developer';
import 'dart:io';
import '../../bot_api/api_services.dart';
import '../../config.dart';

class TranslateController extends GetxController with GetSingleTickerProviderStateMixin  {
  TextEditingController transController = TextEditingController();
  TextEditingController transCompleteController = TextEditingController();
  bool isTranslated = false;
  final FlutterTts? flutterTts = FlutterTts();
  bool isLoader = false;
  dynamic selectItem;
  dynamic toSelectItem;
  dynamic onFromSelect;
  dynamic onToSelect;
  String? response = '';
  int value = 0;

  AnimationController? animationController;
  Animation? animation;

  SpeechToText speech = SpeechToText();
  BannerAd? bannerAd;
  bool bannerAdIsLoaded = false;
  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );
  AdManagerBannerAd? adManagerBannerAd;
  bool adManagerBannerAdIsLoaded = false;

  final _isSpeech = false.obs;
  final isListening = false.obs;
  int toValue = 0;
  List<String> translateLanguagesList = [];
  final FixedExtentScrollController? fromScrollController =
      FixedExtentScrollController();
  final FixedExtentScrollController? toScrollController =
      FixedExtentScrollController();
  final ScrollController? thumbScrollController =
      ScrollController(initialScrollOffset: 50.0);

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
      placementId:  Platform.isAndroid
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
    translateLanguagesList = appArray.translateLanguages;
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


  //stop speech method
  speechStopMethod() async {
    _isSpeech.value = false;
    await flutterTts!.stop();
    update();
  }

  //speech to text
  void speechToText() async {
    speechStopMethod();
    transController.text = '';

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
            transController.text = val.recognizedWords.toString();
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
    transController.clear();
    textToSpeechCtrl.onStopTTS();
    animationController!.dispose();
    super.dispose();
  }


  onTranslate () {
    if(transController.text.isNotEmpty) {
      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "Translate ${transController.text} from ${onFromSelect ??
                appFonts.english} to ${onToSelect ?? appFonts.hindi} language")
            .then((value) {
              if (value != "") {
                response = value;
                update();
                isTranslated = true;
                isLoader = false;
                update();
              } else {
                isLoader = false;
                snackBarMessengers(
                  message: appFonts.somethingWentWrong.tr
                );
                update();
              }
        });
        update();
      }
    } else {
      Get.snackbar(appFonts.attention.tr, appFonts.enterTextBoxValue.tr);
    }
  }

  endTranslationDialog() {
    dialogLayout.endDialog(
        title: appFonts.endTranslation,
        subTitle: appFonts.areYouSure,
        onTap: () {
          transController.clear();
          textToSpeechCtrl.onStopTTS();
          isTranslated = false;
          Get.back();
          update();
        });
  }

  // from languages list
  onFromLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<TranslateController>(builder: (translateCtrl) {
          return LanguagePickerLayout(
            list: translateLanguagesList,
            title: appFonts.selectLanguage,
            index: value,
            scrollController: translateCtrl.fromScrollController,
            thumbScrollController: thumbScrollController,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(value, translateLanguagesList);
            },
            onSuggestionSelected: (i) {
              int index = translateCtrl.translateLanguagesList.indexWhere((element) {
                return element == i;
              });
              translateCtrl.fromScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              translateCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              translateCtrl.update();
            },
            selectOnTap: () {
              onFromSelect = selectItem;
              Get.back();
              translateCtrl.update();
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

  // to language list
  onToLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<TranslateController>(builder: (translateCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: translateLanguagesList,
            index: toValue,
            scrollController: translateCtrl.toScrollController,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(value, translateLanguagesList);
            },
            onSelectedItemChanged: (i) {
              toValue = i;
              toSelectItem = translateLanguagesList[i];
              log("SELECT ITEM: $toSelectItem");
              update();
              translateCtrl.update();
            },
            onSuggestionSelected: (i) {
              int index = translateCtrl.translateLanguagesList.indexWhere((element) {
                return element == i;
              });
              translateCtrl.toScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              translateCtrl.update();
            },
            selectOnTap: () {
              onToSelect = toSelectItem;
              Get.back();
              translateCtrl.update();
            },
          );
        });
      }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppRadius.r10),
            topLeft: Radius.circular(AppRadius.r10)),
      ),
    );
  }
  @override
  void onClose() {
    animationController!.dispose();
    // TODO: implement onClose
    super.onClose();
  }
}
