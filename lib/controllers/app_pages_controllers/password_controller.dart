import 'dart:developer';
import 'dart:io';

import '../../bot_api/api_services.dart';
import '../../config.dart';

class PasswordController extends GetxController {
  TextEditingController passwordController = TextEditingController();

  double value = 11;
  double strengthValue = 0;
  List passwordTypeLists = [];
  List passwordStrengthLists = [];
  int selectedIndex = 0;
  bool isPasswordGenerated = false;
  bool isLoader = false;
  String? response;
  BannerAd? bannerAd;
  bool bannerAdIsLoaded = false;
  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );

  onChangePasswordType(index) {
    selectedIndex = index;
    update();
  }

  onPasswordGenerate() {
    int balance = appCtrl.envConfig["balance"];
    if(balance == 0){
      appCtrl.balanceTopUpDialog();
    }else {
      addCtrl.onInterstitialAdShow();
      isLoader = true;
      ApiServices.chatCompeletionResponse(
          "Create password which length of $value and password type of ${passwordTypeLists[selectedIndex]} and password strength is ${passwordStrengthLists[strengthValue
              .toInt()]} ")
          .then((value) {
            if (value != "") {
              response = value;
              isPasswordGenerated = true;
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

  endPasswordGeneratorDialog() {
    Get.generalDialog(
        pageBuilder: (context, anim1, anim2) {
          return AdviserDialog(
              title: appFonts.endPasswordGenerator,
              subTitle: appFonts.areYouSureEndPasswordGenerator,
              endOnTap: () {
                value = 11;
                strengthValue = 0;
                selectedIndex = 0;
                textToSpeechCtrl.onStopTTS();
                passwordController.clear();
                isPasswordGenerated = false;
                Get.back();
                update();
              });
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                .animate(anim1),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
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
    passwordStrengthLists = appArray.passwordStrengthList;
    passwordTypeLists = appArray.passwordTypeList;
    update();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    value = 11;
    strengthValue = 0;
    selectedIndex = 0;
    passwordController.clear();
    // TODO: implement dispose
    super.dispose();
  }
}
