import 'dart:developer';
import 'dart:io';

import 'package:probot/widgets/balance_alert.dart';

import '../../config.dart';

class AppController extends GetxController {
  AppTheme _appTheme = AppTheme.fromType(ThemeType.light);
  RewardedAd? rewardedAd;
  int numRewardedLoadAttempts = 0;

  AppTheme get appTheme => _appTheme;
  String priceSymbol = "\$";
  bool isTheme = false;
  bool isRTL = false;
  bool isLanguage = false;
  bool isLocalChatApi = false;
  bool isRewardedAdLoaded = false;
  bool isCharacter = false;
  bool isBiometric = false;
  bool isLogin = false;
  bool isChatting = false;
  bool isUserThemeChange = false;
  bool isUserTheme = false;
  bool isUserRTLChange = false;
  bool isUserRTL = false;
  String languageVal = "en";
  dynamic selectedCharacter;
  final storage = GetStorage();

  bool isSwitched = false;
  bool isOnboard = false;
  bool isGuestLogin = false;
  bool isNumber = false;
  dynamic currency;
  dynamic envConfig;
  int characterIndex = 3;
  AdRequest request = const AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  FirebaseConfigModel? firebaseConfigModel;
  CategoryAccessModel? categoryAccessModel;

  //update theme
  updateTheme(theme) {
    _appTheme = theme;
    Get.forceAppUpdate();
  }

  //on drawer Tap
  onDrawerTap(index, data) {
    log("index : E$index");
    Get.back();
    final dashboardCtrl = Get.find<DashboardController>();
    if (data["title"] == "chatBot") {
      dashboardCtrl.onBottomTap(1);
    } else if (data["title"] == "option2") {
      dashboardCtrl.onBottomTap(2);
    } else if (data["title"] == "option3") {
      Get.toNamed(routeName.contentWriterScreen);
    } else if (data["title"] == "setting") {
      Get.toNamed(routeName.settingScreen);
    } else if (data["title"] == "chatHistory") {
      if (appCtrl.isGuestLogin) {
        Get.toNamed(routeName.signInScreen);
      } else {
        Get.toNamed(routeName.chatHistory);
      }
    }
    dashboardCtrl.update();
  }

  void createRewardedAd() {
    appCtrl.firebaseConfigModel = FirebaseConfigModel.fromJson(
        appCtrl.storage.read(session.firebaseConfig));
    RewardedAd.load(
        adUnitId: Platform.isAndroid
            ? appCtrl.firebaseConfigModel!.rewardAndroidId!
            : appCtrl.firebaseConfigModel!.rewardIOSId!,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            log('$ad loaded.');
            rewardedAd = ad;
            numRewardedLoadAttempts = 0;
            update();
          },
          onAdFailedToLoad: (LoadAdError error) {
            log('RewardedAd failed to load: $error');
            rewardedAd = null;
            numRewardedLoadAttempts += 1;
            if (numRewardedLoadAttempts < 3) {
              createRewardedAd();
            }
            update();
          },
        ));
    update();
  }

  void showRewardedAd() async {
    if (rewardedAd == null) {
      log('Warning: attempt to show rewarded before loaded.');
      return;
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          log('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    int count = envConfig["balance"] + appCtrl.firebaseConfigModel!.rewardPoint;
    envConfig["balance"] = count;
    update();
    if (!appCtrl.isGuestLogin) {
      final subscribeCtrl = Get.isRegistered<SubscriptionFirebaseController>()
          ? Get.find<SubscriptionFirebaseController>()
          : Get.put(SubscriptionFirebaseController());
      await subscribeCtrl.addUpdateFirebaseData();
    }
    storage.write(session.envConfig, envConfig);
    envConfig = storage.read(session.envConfig);
    update();

    rewardedAd!.setImmersiveMode(true);
    rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      log('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    rewardedAd = null;
    showNewCount(envConfig["balance"]);
    update();
  }

  showNewCount(count) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return AlertDialogCommon(
              isReward: true,
              height: Sizes.s160,
              reward: count.toString(),
              image: eGifAssets.coin,
              bText1: appFonts.hurrey,
              title: appFonts.congratulationReward,
              subtext: appFonts.congratulationYouGotNewReward,
              style:
                  AppCss.outfitMedium14.textColor(appCtrl.appTheme.lightText),
              b1OnTap: () => Get.back(),
              crossOnTap: () => Get.back());
        });
  }

  void loadRewardedVideoAd() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: Platform.isAndroid ? appCtrl.firebaseConfigModel!.facebookRewardAd! : appCtrl.firebaseConfigModel!.facebookRewardIOSAd!,
      listener: (result, value) {
        log("Rewarded Ad: $result --> $value");
        if (result == RewardedVideoAdResult.LOADED) isRewardedAdLoaded = true;
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
          /// Once a Rewarded Ad has been closed and becomes invalidated,
          /// load a fresh Ad by calling this function.
          if (result == RewardedVideoAdResult.VIDEO_CLOSED &&
              (value == true || value["invalidated"] == true)) {
            isRewardedAdLoaded = false;
            loadRewardedVideoAd();
          }
        }
      },
    );
  }

  showFacebookRewardedAd() async{
    if (isRewardedAdLoaded == true) {
      FacebookRewardedVideoAd.showRewardedVideoAd();
      int count = envConfig["balance"] + appCtrl.firebaseConfigModel!.rewardPoint;
      envConfig["balance"] = count;
      update();
      if (!appCtrl.isGuestLogin) {
        final subscribeCtrl = Get.isRegistered<SubscriptionFirebaseController>()
            ? Get.find<SubscriptionFirebaseController>()
            : Get.put(SubscriptionFirebaseController());
        await subscribeCtrl.addUpdateFirebaseData();
      }
      storage.write(session.envConfig, envConfig);
      envConfig = storage.read(session.envConfig);
      update();
      showNewCount(envConfig["balance"]);
    } else {
      log("Rewarded Ad not yet loaded!");
    }
  }

  //balance top up
  balanceTopUpDialog() {

      Get.generalDialog(
        pageBuilder: (context, anim1, anim2) {
          return const Align(
            alignment: Alignment.center,
            child: BalanceAlertDialog(),
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


  splashDataCheck() async {
    bool isLoginSave = appCtrl.storage.read(session.isLogin) ?? false;
    bool isGuestLogin = appCtrl.storage.read(session.isGuestLogin) ?? false;
    bool isBiometricSave = appCtrl.storage.read(session.isBiometric) ?? false;
    bool isLanguageSaved = appCtrl.storage.read(session.isLanguage) ?? false;
    var name = appCtrl.storage.read("name");
    var userName = appCtrl.storage.read("userName");
    var firebaseUser = appCtrl.storage.read("firebaseUser");
    var number = appCtrl.storage.read("number");
    if (isGuestLogin) {
      appCtrl.isGuestLogin = isGuestLogin;
      appCtrl.storage.write(session.isGuestLogin, isGuestLogin);
      Get.offAllNamed(routeName.dashboard);
    } else {
      appCtrl.isGuestLogin = false;
      appCtrl.storage.write(session.isGuestLogin, false);

      if (isLoginSave) {
        if (isBiometricSave) {
          Get.offAllNamed(routeName.addFingerprintScreen);
        } else {
          Get.offAllNamed(routeName.dashboard);
        }
      } else {
        if (name != null ||
            userName != null ||
            firebaseUser != null ||
            number != null) {
          if (isLanguageSaved) {
            if (isBiometricSave) {
              Get.offAllNamed(routeName.addFingerprintScreen);
            } else {
              Get.offAllNamed(routeName.dashboard);
            }
          } else {
            Get.offAllNamed(routeName.selectLanguageScreen);
          }
        } else {
          Get.offAllNamed(routeName.loginScreen);
        }
      }
    }
  }

  commonThemeChange()async{
    await FirebaseFirestore.instance.collection("config").get().then((value) {
      if (value.docs.isNotEmpty) {
        appCtrl.firebaseConfigModel =
            FirebaseConfigModel.fromJson(value.docs[0].data());

        if(isUserThemeChange == false) {

          if (appCtrl.firebaseConfigModel!.isTheme! != appCtrl.isTheme) {
            appCtrl.isTheme = appCtrl.firebaseConfigModel!.isTheme!;
            appCtrl.update();
            ThemeService().switchTheme(appCtrl.isTheme);
            Get.forceAppUpdate();
            appCtrl.storage.write(session.firebaseConfig, value.docs[0].data());
            if(!appCtrl.isGuestLogin) {
              appCtrl.envConfig["balance"] =
                  appCtrl.firebaseConfigModel!.balance;
            }
            appCtrl.update();
            appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
          }
        }
        if(isUserRTLChange == false) {
          if( appCtrl.isRTL != appCtrl.firebaseConfigModel!.isRTL!) {
            appCtrl.isRTL = appCtrl.firebaseConfigModel!.isRTL!;
            log("appCtrl.isRTL : ${appCtrl.isRTL}");
            appCtrl.storage
                .write(session.isRTL, appCtrl.isRTL);
            appCtrl.update();
            Get.forceAppUpdate();
          }
        }

      }

    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    rewardedAd?.dispose();
    super.dispose();
  }
}
