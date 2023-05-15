import 'dart:developer';
import 'dart:io';

import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class GetWellMessageController extends GetxController {
  TextEditingController wellGenController = TextEditingController();
  TextEditingController wellWishesGenController = TextEditingController();
  TextEditingController relationGenController = TextEditingController();
  TextEditingController whatHappenController = TextEditingController();
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
  bool isWellMessageGenerated = false;
  bool isLoader = false;
  String? response;

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

  onWellMessageGenerate() {
    if(scaffoldKey.currentState!.validate()) {
      int balance = appCtrl.envConfig["balance"];
      if(balance == 0){
        appCtrl.balanceTopUpDialog();
      }else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "get well soon message to ${relationGenController
                .text} ${wellWishesGenController
                .text} for ${whatHappenController.text}").then((value) {
                  if (value != "") {
                    response = value;
                    update();
                    isLoader = false;
                    isWellMessageGenerated = true;
                    update();
                  } else {
                    isLoader = false;
                    snackBarMessengers(message: appFonts.somethingWentWrong.tr);
                    update();
                  }
        });
        wellGenController.clear();
        wellWishesGenController.clear();
        relationGenController.clear();
        whatHappenController.clear();
        update();
      }}
  }

  endWellWishes() {
    dialogLayout.endDialog(
        title: appFonts.endWellWishes,
        subTitle: appFonts.areYouSureEndWell,
        onTap: () {
          wellGenController.clear();
          wellWishesGenController.clear();
          relationGenController.clear();
          whatHappenController.clear();
          textToSpeechCtrl.onStopTTS();
              isWellMessageGenerated = false;
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
    wellGenController.clear();
    wellWishesGenController.clear();
    relationGenController.clear();
    whatHappenController.clear();
    // TODO: implement dispose
    super.dispose();
  }

}
