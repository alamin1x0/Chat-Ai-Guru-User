import 'dart:developer';
import 'dart:io';

import '../../bot_api/api_services.dart';
import '../../config.dart';

class DistanceAttractionController extends GetxController {
  TextEditingController controller = TextEditingController();
  SfRangeValues values = const SfRangeValues(10, 20);
  List cityLists = [];
  List placeLists = [];

  bool isDistanceGenerated = false;
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

  onDistanceGenerate() {

      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
                "I m looking place for ${onSelect ?? "Surat"} in ${placeOnSelect ?? "Restaurant"} with Budget of travelling/hangout between ${values.start }thousand to ${values.end }thousand")
            .then((value) {
              if (value != "") {
                response = value;
                update();
                controller.text = '';
                isLoader = false;
                isDistanceGenerated = true;
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

  endDistanceGenerator() {
    dialogLayout.endDialog(
        title: appFonts.endTraveling,
        subTitle: appFonts.areYouSureEndTravelling,
        onTap: () {
          controller.clear();
          isDistanceGenerated = false;
          textToSpeechCtrl.onStopTTS();
          Get.back();
          update();
        });
  }

  onCitySheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<DistanceAttractionController>(
            builder: (distanceCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectPlaceCategory,
            list: distanceCtrl.cityLists,
            index: value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, distanceCtrl.cityLists.cast<String>());
            },
            scrollController: distanceCtrl.scrollController,
            onSuggestionSelected: (i) {
              int index = distanceCtrl.cityLists.indexWhere((element) {
                return element == i;
              });
              distanceCtrl.scrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              distanceCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = distanceCtrl.cityLists[i];
              log("SELECT ITEM: $selectItem");
              update();
              distanceCtrl.update();
            },
            selectOnTap: () {
              onSelect = selectItem;
              Get.back();
              distanceCtrl.update();
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
        return GetBuilder<DistanceAttractionController>(
            builder: (distanceCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectPlaceCategory,
            list: distanceCtrl.placeLists,
            index: placeValue,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, distanceCtrl.placeLists.cast<String>());
            },
            scrollController: distanceCtrl.placeScrollController,
            onSuggestionSelected: (i) {
              int index = distanceCtrl.placeLists.indexWhere((element) {
                return element == i;
              });
              distanceCtrl.placeScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              distanceCtrl.update();
            },
            onSelectedItemChanged: (i) {
              placeValue = i;
              placeSelectItem = distanceCtrl.placeLists[i];
              log("SELECT ITEM: $placeSelectItem");
              update();
              distanceCtrl.update();
            },
            selectOnTap: () {
              placeOnSelect = placeSelectItem;
              Get.back();
              distanceCtrl.update();
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

    cityLists = appArray.cityList;
    placeLists = appArray.placeList;
    update();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    controller.clear();
    // TODO: implement dispose
    super.dispose();
  }
}
