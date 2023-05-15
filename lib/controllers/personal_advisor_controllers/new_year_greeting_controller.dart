import 'dart:developer';
import 'dart:io';

import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class NewYearGreetingController extends GetxController {
  bool isGreetingGenerate = false;
  bool isLoader = false;
  final FixedExtentScrollController? languageScrollController =
      FixedExtentScrollController();
  TextEditingController yearController = TextEditingController();
  TextEditingController sendWishesController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController newYearWishGenController = TextEditingController();
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();

  int value = 0;
  String? selectItem;
  String? onSelect;
  String? response = '';

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

  onNewYearWishesGenerate() {
    if(scaffoldKey.currentState!.validate()) {
      int balance = appCtrl.envConfig["balance"];
      if(balance == 0){
        appCtrl.balanceTopUpDialog();
      }else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "Happy new year ${yearController.text} message for ${nameController
                .text} from ${sendWishesController.text} in ${selectItem ??
                "English"}").then((value) {
                  if (value != "") {
                    response = value;
                    update();
                    isLoader = false;
                    isGreetingGenerate = true;
                    update();
                  }else {
                    isLoader = false;
                    snackBarMessengers(message: appFonts.somethingWentWrong.tr);
                    update();
                  }
        });
        yearController.clear();
        sendWishesController.clear();
        nameController.clear();
        newYearWishGenController.clear();
        selectItem = '';
        update();
      }}
  }

  onLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<NewYearGreetingController>(builder: (newYearCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: newYearCtrl.langCtrl.translateLanguagesList,
            index: newYearCtrl.value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, newYearCtrl.langCtrl.translateLanguagesList);
            },
            scrollController: newYearCtrl.languageScrollController,
            onSuggestionSelected: (i) {
              int index = newYearCtrl.langCtrl.translateLanguagesList
                  .indexWhere((element) {
                return element == i;
              });
              newYearCtrl.languageScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              newYearCtrl.update();
            },
            onSelectedItemChanged: (i) {
              newYearCtrl.value = i;
              newYearCtrl.selectItem =
                  newYearCtrl.langCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              newYearCtrl.update();
            },
            selectOnTap: () {
              newYearCtrl.onSelect = newYearCtrl.selectItem;
              Get.back();
              newYearCtrl.update();
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

  endNewYearGreeting() {
    dialogLayout.endDialog(
        title: appFonts.endNewYearGreeting,
        subTitle: appFonts.areYouSureEndGreeting,
        onTap: () {
          yearController.clear();
          sendWishesController.clear();
          nameController.clear();
          newYearWishGenController.clear();
          selectItem = '';
          isGreetingGenerate = false;
          Get.back();
          update();
        });
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
    yearController.clear();
    sendWishesController.clear();
    nameController.clear();
    newYearWishGenController.clear();
    selectItem = '';
    textToSpeechCtrl.onStopTTS();
    // TODO: implement dispose
    super.dispose();
  }

}
