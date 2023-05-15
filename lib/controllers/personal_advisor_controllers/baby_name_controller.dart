import 'dart:developer';
import 'dart:io';
import 'package:probot/bot_api/api_services.dart';
import '../../config.dart';

class BabyNameSuggestionController extends GetxController {
  TextEditingController latterController = TextEditingController();
  TextEditingController generatedNameController = TextEditingController();
  final FixedExtentScrollController? scrollController =
      FixedExtentScrollController();
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();

  List genderLists = [];
  List nameSuggestionLists = [];
  List<String> zodiacLists = [];
  int? selectedIndex = 0;
  int? selectedNameIndex = 0;
  bool isNameGenerate = false;
  bool isLoader = false;
  int value = 0;
  String? selectItem;
  String? onSelect;
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

  onGenderChange(index) {
    selectedIndex = index;
    update();
  }

  onNameSuggestionChange(index) {
    selectedNameIndex = index;
    update();
  }

  onNameGenerate() {
    if(scaffoldKey.currentState!.validate()) {
      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(selectedNameIndex == 0
            ? "Suggest a 10 ${genderLists[selectedIndex!]['title']} name with ${selectItem ??
            "Capricorn"} Zodiac"
            : "Suggest a 10 ${genderLists[selectedIndex!]['title']} name start with ${latterController
            .text}")
            .then((value) {
              if (value != "") {
                response = value;
                update();
                isLoader = false;
                selectedIndex = 0;
                selectedNameIndex = 0;
                selectItem = '';
                latterController.text = '';
                isNameGenerate = true;
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
  }

  endNameSuggestion() {
    dialogLayout.endDialog(
        title: appFonts.endNameSuggestion,
        subTitle: appFonts.areYouSureEndBabyName,
        onTap: () {
          selectItem = '';
          latterController.text = '';
          textToSpeechCtrl.onStopTTS();
          isNameGenerate = false;
          Get.back();
          update();
        });
  }

  onZodiacSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<BabyNameSuggestionController>(builder: (babyCtrl) {
          return LanguagePickerLayout(
            image: eSvgAssets.zodiac,
            title: appFonts.selectLanguage,
            list: babyCtrl.zodiacLists,
            index: value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(value, babyCtrl.zodiacLists);
            },
            scrollController: babyCtrl.scrollController,
            onSuggestionSelected: (i) {
              int index = babyCtrl.zodiacLists.indexWhere((element) {
                return element == i;
              });
              babyCtrl.scrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              babyCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = babyCtrl.zodiacLists[i];
              log("SELECT ITEM: $selectItem");
              update();
              babyCtrl.update();
            },
            selectOnTap: () {
              onSelect = selectItem;
              Get.back();
              babyCtrl.update();
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

  onTapClearCtrlTTS() {
    textToSpeechCtrl.onStopTTS();
    latterController.clear();
    generatedNameController.clear();
    update();
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
    genderLists = appArray.genderList;
    nameSuggestionLists = appArray.nameSuggestionList;
    zodiacLists = appArray.zodiacList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
