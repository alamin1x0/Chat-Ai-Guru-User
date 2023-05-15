import 'dart:developer';
import 'dart:io';
import '../../config.dart';

class HomeController extends GetxController {
  List<HomeOptionModel> homeOptionList = [];
  List drawerList = [];
  List quickAdvisorLists = [];
  BannerAd? bannerAd;
  bool bannerAdIsLoaded = false;

  AdManagerBannerAd? adManagerBannerAd;
  bool adManagerBannerAdIsLoaded = false;

  NativeAd? nativeAd;

  Widget currentAd = const SizedBox(
    width: 0.0,
    height: 0.0,
  );
  bool nativeAdIsLoaded = false;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final quickAdvisorCtrl = Get.isRegistered<QuickAdvisorController>()
      ? Get.find<QuickAdvisorController>()
      : Get.put(QuickAdvisorController());

  @override
  void onReady() {
    // TODO: implement onReady
    homeOptionList = appArray.homeOptionList
        .map((e) => HomeOptionModel.fromJson(e))
        .toList();
    drawerList = appArray.drawerList;
    quickAdvisorLists = appArray.quickAdvisor.getRange(0, 6).toList();

    update();

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
    super.onReady();
  }

  getQuickData() async {
    quickAdvisorLists = [];
    List quickLists = appArray.quickAdvisor.getRange(0, 6).toList();
    quickLists.asMap().entries.forEach((element) {
      if (element.value["title"] == "askAnything") {
        if (appCtrl.firebaseConfigModel!.isChatShow!) {
          quickAdvisorLists.add(element.value);
        }
      }
      if (element.value["title"] == "codeGenerator") {
        if (appCtrl.categoryAccessModel!.isCodeGeneratorEnable!) {
          quickAdvisorLists.add(element.value);
        }
      }
      if (element.value["title"] == "translateAnything") {
        if (appCtrl.categoryAccessModel!.isTranslateAnythingEnable!) {
          quickAdvisorLists.add(element.value);
        }
      }
      if (element.value["title"] == "socialMedia") {
        if (appCtrl.categoryAccessModel!.isSocialMediaEnable!) {
          quickAdvisorLists.add(element.value);
        }
      }
      if (element.value["title"] == "emailGenerator") {
        if (appCtrl.categoryAccessModel!.isEmailGeneratorEnable!) {
          quickAdvisorLists.add(element.value);
        }
      }
      if (element.value["title"] == "personalAdvice") {
        if (appCtrl.categoryAccessModel!.isPersonalAdvisorEnable!) {
          quickAdvisorLists.add(element.value);
        }
      }
      if (element.value["title"] == "passwordGenerator") {
        if (appCtrl.categoryAccessModel!.isPasswordGeneratorEnable!) {
          quickAdvisorLists.add(element.value);
        }
      }
      if (element.value["title"] == "travelHangout") {
        if (appCtrl.categoryAccessModel!.isTravelEnable!) {
          quickAdvisorLists.add(element.value);
        }
      }
      if (element.value["title"] == "essayWriter") {
        if (appCtrl.categoryAccessModel!.isEssayWriterEnable!) {
          quickAdvisorLists.add(element.value);
        }
      }
      if (element.value["title"] == "content") {
        if (appCtrl.categoryAccessModel!.isContentWritingEnable!) {
          quickAdvisorLists.add(element.value);
        }
      }
    });
  }

  getFavData() async {
    List<dynamic> favList = appCtrl.storage.read("favList") ?? [];
    log("FAVE : $favList");
    if (favList.isNotEmpty) {
      favList.asMap().entries.forEach((element) {
        if (element.value["title"] == "askAnything") {
          if (!appCtrl.firebaseConfigModel!.isChatShow!) {
            quickAdvisorCtrl.onTapRemoveFavorite(element.key);
          }
        }
        if (element.value["title"] == "codeGenerator") {
          if (!appCtrl.categoryAccessModel!.isCodeGeneratorEnable!) {
            quickAdvisorCtrl.onTapRemoveFavorite(element.key);
          }
        }
        if (element.value["title"] == "translateAnything") {
          if (!appCtrl.categoryAccessModel!.isTranslateAnythingEnable!) {
            quickAdvisorCtrl.onTapRemoveFavorite(element.key);
          }
        }
        if (element.value["title"] == "socialMedia") {
          if (!appCtrl.categoryAccessModel!.isSocialMediaEnable!) {
            quickAdvisorCtrl.onTapRemoveFavorite(element.key);
          }
        }
        if (element.value["title"] == "emailGenerator") {
          if (!appCtrl.categoryAccessModel!.isEmailGeneratorEnable!) {
            quickAdvisorCtrl.onTapRemoveFavorite(element.key);
          }
        }
        if (element.value["title"] == "personalAdvice") {
          if (!appCtrl.categoryAccessModel!.isPersonalAdvisorEnable!) {
           quickAdvisorCtrl.onTapRemoveFavorite(element.key);
          }
        }
        if (element.value["title"] == "passwordGenerator") {
          if (!appCtrl.categoryAccessModel!.isPasswordGeneratorEnable!) {
           quickAdvisorCtrl.onTapRemoveFavorite(element.key);
          }
        }
        if (element.value["title"] == "travelHangout") {
          if (!appCtrl.categoryAccessModel!.isTravelEnable!) {
           quickAdvisorCtrl.onTapRemoveFavorite(element.key);
          }
        }
        if (element.value["title"] == "essayWriter") {
          if (!appCtrl.categoryAccessModel!.isEssayWriterEnable!) {
           quickAdvisorCtrl.onTapRemoveFavorite(element.key);
          }
        }
        if (element.value["title"] == "content" ||
            element.value["title"] == "Content") {
          if (!appCtrl.categoryAccessModel!.isContentWritingEnable!) {
           quickAdvisorCtrl.onTapRemoveFavorite(element.key);
          }
        }

        appCtrl.storage.write("removeFav", element.key);
      });
    }
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

  //on option tap function
  onOptionTap(data) {
    log("TITLE : $data");
    final dashboardCtrl = Get.find<DashboardController>();
    if (data.title == "option1") {
      dashboardCtrl.onBottomTap(1);
    } else if (data.title == "option2") {
      dashboardCtrl.onBottomTap(2);
    } else {
      dashboardCtrl.onBottomTap(3);
    }
    dashboardCtrl.update();
  }

  onTapWatch() {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return AlertDialogCommon(
              isReward: true,
              height: Sizes.s160,
              reward: appCtrl.envConfig["chatTextCount"].toString(),
              image: eImageAssets.reward,
              bText1: appFonts.watchVideo,
              title: appFonts.availableBalance.tr,
              subtext: appFonts.watchTheVideoToWin,
              style:
                  AppCss.outfitMedium14.textColor(appCtrl.appTheme.lightText),
              b1OnTap: () {
                Get.back();
                Get.back();
                if (appCtrl.firebaseConfigModel!.isGoogleAdmobEnable!) {
                  if (appCtrl.rewardedAd == null) {
                    appCtrl.createRewardedAd();
                  }
                  appCtrl.showRewardedAd();
                } else {
                  if (appCtrl.isRewardedAdLoaded == false) {
                    appCtrl.loadRewardedVideoAd();
                  }
                  appCtrl.showFacebookRewardedAd();
                }
              },
              crossOnTap: () => Get.back());
        });
  }

  onTapGoOtherPage (data) {
      if (data["title"] == appFonts.translateAnything) {
        Get.toNamed(routeName.translateScreen);
      } else if (data["title"] == appFonts.codeGenerator) {
        Get.toNamed(routeName.codeGeneratorScreen);
      } else if (data["title"] == appFonts.emailGenerator) {
        Get.toNamed(routeName.emailWriterScreen);
      } else if (data["title"] == appFonts.socialMedia) {
        Get.toNamed(routeName.socialMediaScreen);
      } else if (data["title"] == appFonts.passwordGenerator) {
        Get.toNamed(routeName.passwordGeneratorScreen);
      } else if (data["title"] == appFonts.essayWriter) {
        Get.toNamed(routeName.essayWriterScreen);
      } else if (data["title"] == appFonts.travelHangout) {
        Get.toNamed(routeName.travelScreen);
      } else if (data["title"] == appFonts.personalAdvice) {
        Get.toNamed(routeName.personalAdvisorScreen);
      } else if (data["title"] == appFonts.content1) {
        Get.toNamed(routeName.contentWriterScreen);
      } else {
        Get.toNamed(routeName.chatLayout);
        final chatCtrl = Get.isRegistered<ChatLayoutController>()
            ? Get.find<ChatLayoutController>()
            : Get.put(ChatLayoutController());
        chatCtrl.getChatId();
        update();
      }
  }


  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    bannerAd?.dispose();
    bannerAd = null;
    super.dispose();
  }
}
