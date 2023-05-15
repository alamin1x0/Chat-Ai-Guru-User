import 'dart:developer';
import 'dart:io';

import '../../bot_api/api_services.dart';
import '../../config.dart';

class NearbyPointsController extends GetxController {
  SfRangeValues values = const SfRangeValues(05, 15);
  bool isNearbyPointsGenerated = false;
  TextEditingController nearbyController = TextEditingController();
  final FixedExtentScrollController? scrollController =
  FixedExtentScrollController();
  final FixedExtentScrollController? placeScrollController =
  FixedExtentScrollController();
  int value = 0;
  String? selectItem;
  String? onSelect;
  bool isLoader = false;
  int placeValue = 0;
  String? placeSelectItem;
  String? placeOnSelect;
  String? response;
  List cityLists = [];
  List placeLists = [];
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

  onNearbyPointGenerate() {

      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "I m looking place for ${onSelect ?? "Surat"} in ${placeOnSelect ?? "Restaurant"} Distance from ${placeOnSelect ?? "Restaurant"} ${values.start}km to ${values.end}km")
            .then((value) {
              log("*** $value");
              if (value != "") {
                response = value;
                update();
                nearbyController.text = '';
                isLoader = false;
                isNearbyPointsGenerated = true;
                update();
              } else {
                isLoader = false;
                snackBarMessengers(message: appFonts.somethingWentWrong.tr);
                update();
              }
        });
        update();
      }
    update();
  }

  onCitySheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<NearbyPointsController>(
            builder: (nearCtrl) {
              return LanguagePickerLayout(
                title: appFonts.selectPlaceCategory,
                list: nearCtrl.cityLists,
                index: value,
                suggestionsCallbacks: (value) {
                  return StateService.getSuggestions(
                      value, nearCtrl.cityLists.cast<String>());
                },
                scrollController: nearCtrl.scrollController,
                onSuggestionSelected: (i) {
                  int index = nearCtrl.cityLists.indexWhere((element) {
                    return element == i;
                  });
                  nearCtrl.scrollController!.jumpToItem(index);
                  log("suggestion: $i");
                  log("index: $index");
                  update();
                  nearCtrl.update();
                },
                onSelectedItemChanged: (i) {
                  value = i;
                  selectItem = nearCtrl.cityLists[i];
                  log("SELECT ITEM: $selectItem");
                  update();
                  nearCtrl.update();
                },
                selectOnTap: () {
                  onSelect = selectItem;
                  Get.back();
                  nearCtrl.update();
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

  onPlaceSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<NearbyPointsController>(
            builder: (nearCtrl) {
              return LanguagePickerLayout(
                title: appFonts.selectPlaceCategory,
                list: nearCtrl.placeLists,
                index: placeValue,
                suggestionsCallbacks: (value) {
                  return StateService.getSuggestions(
                      value, nearCtrl.placeLists.cast<String>());
                },
                scrollController: nearCtrl.placeScrollController,
                onSuggestionSelected: (i) {
                  int index = nearCtrl.placeLists.indexWhere((element) {
                    return element == i;
                  });
                  nearCtrl.placeScrollController!.jumpToItem(index);
                  log("suggestion: $i");
                  log("index: $index");
                  update();
                  nearCtrl.update();
                },
                onSelectedItemChanged: (i) {
                  placeValue = i;
                  placeSelectItem = nearCtrl.placeLists[i];
                  log("SELECT ITEM: $placeSelectItem");
                  update();
                  nearCtrl.update();
                },
                selectOnTap: () {
                  placeOnSelect = placeSelectItem;
                  Get.back();
                  nearCtrl.update();
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

  endNearbyGeneratorDialog() {
    Get.generalDialog(
        pageBuilder: (context, anim1, anim2) {
          return AdviserDialog(
              title: appFonts.endTraveling,
              subTitle: appFonts.areYouSureEndTravelling,
              endOnTap: () {
                nearbyController.clear();
                textToSpeechCtrl.onStopTTS();
                isNearbyPointsGenerated = false;
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

    cityLists = appArray.cityList;
    placeLists = appArray.placeList;
    update();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    nearbyController.clear();
    textToSpeechCtrl.onStopTTS();
    // TODO: implement dispose
    super.dispose();
  }
}
