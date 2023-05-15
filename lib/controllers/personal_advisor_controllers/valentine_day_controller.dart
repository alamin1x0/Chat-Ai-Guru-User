import 'dart:developer';
import 'dart:io';

import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class ValentineDayController extends GetxController {
  final transCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());

  TextEditingController valWishGenController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController wishForController = TextEditingController();
  final FixedExtentScrollController? scrollController =
      FixedExtentScrollController();
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();

  String? selectItem;
  String? onSelectItem;
  String? response;
  int value = 0;

  bool isValentineGenerate = false;
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
      placementId: Platform.isAndroid
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

  onValWishesGenerate() {
    if (scaffoldKey.currentState!.validate()) {
      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
                "Write a Valentine's day wish message for ${wishForController.text} from ${nameController.text} in ${selectItem ?? "English"}")
            .then((value) {
          if (value != "") {
            response = value;
            update();
            isLoader = false;
            isValentineGenerate = true;
            update();
          } else {
            isLoader = false;
            snackBarMessengers(message: appFonts.somethingWentWrong.tr);
            update();
          }
        });
        valWishGenController.clear();
        nameController.clear();
        wishForController.clear();
        selectItem = "";
        update();
      }
    }
  }

  endValentine() {
    dialogLayout.endDialog(
        title: appFonts.endValentineMessage,
        subTitle: appFonts.areYouSureEndValentine,
        onTap: () {
          valWishGenController.clear();
          nameController.clear();
          wishForController.clear();
          selectItem = "";
          textToSpeechCtrl.onStopTTS();
          isValentineGenerate = false;
          Get.back();
          update();
        });
  }

  onToLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<ValentineDayController>(builder: (valCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: valCtrl.transCtrl.translateLanguagesList,
            index: value,
            scrollController: valCtrl.scrollController,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, valCtrl.transCtrl.translateLanguagesList);
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = valCtrl.transCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              valCtrl.update();
            },
            onSuggestionSelected: (i) {
              int index = valCtrl.transCtrl.translateLanguagesList
                  .indexWhere((element) {
                return element == i;
              });
              valCtrl.scrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              valCtrl.update();
            },
            selectOnTap: () {
              onSelectItem = selectItem;
              Get.back();
              valCtrl.update();
            },
          );
        });
      }),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(AppRadius.r10),
            topLeft: Radius.circular(AppRadius.r10)),
      ),
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
    valWishGenController.clear();
    nameController.clear();
    wishForController.clear();
    selectItem = "";
    textToSpeechCtrl.onStopTTS();
    // TODO: implement dispose
    super.dispose();
  }
}
