import 'dart:developer';
import 'dart:io';
import '../../config.dart';

class AdController extends GetxController {
  BannerAd? bannerAd;
  bool bannerAdIsLoaded = false;

  AdManagerBannerAd? adManagerBannerAd;
  bool adManagerBannerAdIsLoaded = false;
  bool isInterstitialAdLoaded = false;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  NativeAd? nativeAd;

  Widget  currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );
  bool nativeAdIsLoaded = false;


  onInterstitialAdShow() {
    if (appCtrl.firebaseConfigModel!.isAddShow!) {
      if (appCtrl.firebaseConfigModel!.isGoogleAdmobEnable!) {
        log("FB");
        showInterstitialAd();
      } else {

        loadInterstitialAd();
      }
    }
    update();
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

  void loadInterstitialAd() {
    FacebookAudienceNetwork.init(
      testingId: Platform.isAndroid
          ? appCtrl.firebaseConfigModel!.facebookInterstitialAd!
          : appCtrl.firebaseConfigModel!.facebookInterstitialIOSAd!,
      iOSAdvertiserTrackingEnabled: true,
    );

    FacebookInterstitialAd.loadInterstitialAd(
      placementId: appCtrl.firebaseConfigModel!.facebookInterstitialAd!,
      listener: (result, value) {
        log("resultAD : $result");
        log("result1AD : ${result.name}");
        log("resultAD2 : $value");
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
      log("Interstitial Ad not yet loaded!");
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
      log('Warning: AD attempt to show interstitial before loaded.');
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

  onBannerAds () {
    appCtrl.firebaseConfigModel = FirebaseConfigModel.fromJson(
        appCtrl.storage.read(session.firebaseConfig));
    if (bannerAd == null && bannerAdIsLoaded == false) {
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
  }

  @override
  void onInit() async{
    log("ENVCONFIG : ${appCtrl.storage.read(session.firebaseConfig)}");
    log("FIREBASE : ${ appCtrl.firebaseConfigModel}");
    if (appCtrl.storage.read(session.firebaseConfig) == null ) {
      await FirebaseFirestore.instance.collection("config").get().then((value) {
        log("VALUE: ${value.docs.isNotEmpty}");
        if (value.docs.isNotEmpty) {
          appCtrl.firebaseConfigModel =
              FirebaseConfigModel.fromJson(value.docs[0].data());

          appCtrl.isTheme = appCtrl.firebaseConfigModel!.isTheme!;
          appCtrl.isRTL = appCtrl.firebaseConfigModel!.isRTL!;
          appCtrl.storage.write(session.isRTL, appCtrl.isRTL);
          appCtrl.update();
          ThemeService().switchTheme(appCtrl.isTheme);
          Get.forceAppUpdate();
          appCtrl.storage.write(session.firebaseConfig, value.docs[0].data());
          appCtrl.envConfig["balance"] = appCtrl.firebaseConfigModel!.balance;
          appCtrl.update();
          appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
          log("FIREBASE INNN : ${ appCtrl.firebaseConfigModel}");
        }
      } ).then((value) => onBannerAds ());
    } else {
      onBannerAds ();
    }

log("BANNER: ${appCtrl.firebaseConfigModel!}");
    _getId().then((id) {
      String? deviceId = id;

      FacebookAudienceNetwork.init(
        testingId: deviceId,
        iOSAdvertiserTrackingEnabled: true,
      );
    });
    _showBannerAd();
    if (appCtrl.firebaseConfigModel!.isAddShow!) {
      _createInterstitialAd();
    }
    loadInterstitialAd();
    update();
    super.onInit();

  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    bannerAd?.dispose();
    bannerAd = null;
    super.dispose();
  }
}
