import 'dart:developer';
import 'dart:io';
import 'package:probot/bot_api/api_services.dart';
import '../../config.dart';

class WeddingWishesController extends GetxController {
  List<String> anniversaryYearList =
      List<String>.generate(70, (counter) => "${counter + 1}");
  final FixedExtentScrollController? anniYearScrollController =
      FixedExtentScrollController();
  final FixedExtentScrollController? languageScrollController =
      FixedExtentScrollController();
  TextEditingController wishGenController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  int value = 0;
  int langValue = 0;
  String? selectItem;
  String? langSelectItem;
  String? onSelect;
  String? langOnSelect;
  String? response;
  bool isWeddingWishGenerate = false;
  bool isLoader = false;
  BannerAd? bannerAd;
  bool bannerAdIsLoaded = false;
  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );

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

  final langCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();

  onMessageGenerate() {
    if(scaffoldKey.currentState!.validate()) {
      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "I want to wish ${nameController
                .text} for wedding to ${relationController
                .text} in ${selectItem ?? "English"}").then((value) {
                  if (value != "") {
                    response = value;
                    update();
                    isLoader = false;
                    isWeddingWishGenerate = true;
                    update();
                  } else {
                    isLoader = false;
                    snackBarMessengers(message: appFonts.somethingWentWrong.tr);
                    update();
                  }
        });
        wishGenController.clear();
        relationController.clear();
        nameController.clear();
        selectItem = '';
        langSelectItem = '';
        update();
      }}
  }

  endWeddingWishes() {
    dialogLayout.endDialog(
        title: appFonts.endWeddingWishes,
        subTitle: appFonts.areYouSureEndWedding,
        onTap: () {
          wishGenController.clear();
          relationController.clear();
          nameController.clear();
          textToSpeechCtrl.onStopTTS();
          selectItem = '';
          langSelectItem = '';
          isWeddingWishGenerate = false;
          Get.back();
          update();
        });
  }

  onLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<WeddingWishesController>(builder: (weddingCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: weddingCtrl.langCtrl.translateLanguagesList,
            index: langValue,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, weddingCtrl.langCtrl.translateLanguagesList);
            },
            scrollController: weddingCtrl.languageScrollController,
            onSuggestionSelected: (i) {
              int index = weddingCtrl.langCtrl.translateLanguagesList
                  .indexWhere((element) {
                return element == i;
              });
              weddingCtrl.languageScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              weddingCtrl.update();
            },
            onSelectedItemChanged: (i) {
              langValue = i;
              langSelectItem = weddingCtrl.langCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              weddingCtrl.update();
            },
            selectOnTap: () {
              langOnSelect = langSelectItem;
              Get.back();
              weddingCtrl.update();
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

  onWeddingAnniSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<WeddingWishesController>(builder: (weddingCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: weddingCtrl.anniversaryYearList,
            index: value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, weddingCtrl.anniversaryYearList);
            },
            scrollController: weddingCtrl.anniYearScrollController,
            onSuggestionSelected: (i) {
              int index = weddingCtrl.anniversaryYearList.indexWhere((element) {
                return element == i;
              });
              weddingCtrl.anniYearScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              weddingCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = weddingCtrl.anniversaryYearList[i];
              log("SELECT ITEM: $selectItem");
              update();
              weddingCtrl.update();
            },
            selectOnTap: () {
              onSelect = selectItem;
              Get.back();
              weddingCtrl.update();
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
    update();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    wishGenController.clear();
    relationController.clear();
    nameController.clear();
    textToSpeechCtrl.onStopTTS();
    selectItem = '';
    langSelectItem = '';
    // TODO: implement dispose
    super.dispose();
  }

}
