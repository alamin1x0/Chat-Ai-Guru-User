import 'dart:developer';
import 'dart:io';
import 'package:probot/bot_api/api_services.dart';
import '../../config.dart';

class BirthdayMessageController extends GetxController {
  TextEditingController birthdayMessagesGenController = TextEditingController();
  TextEditingController birthdayWishGenController = TextEditingController();
  TextEditingController nameGenController = TextEditingController();
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
  bool isBirthdayGenerated = false;
  bool isLoader = false;
  String? response;

  final FixedExtentScrollController? scrollController =
      FixedExtentScrollController();
  int value = 0;
  String? selectItem;
  String? onSelect;
  final langCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());


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


  onTapWishesGenerate() {
    if(scaffoldKey.currentState!.validate()) {
      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "Birthday wish message for ${birthdayWishGenController
                .text} with ${nameGenController.text} name in ${selectItem ??
                "Hindi"}").then((value) {
                  if (value != "") {
                    response = value;
                    update();
                    isBirthdayGenerated = true;
                    isLoader = false;
                    update();
                  } else {
                    isLoader = false;
                    snackBarMessengers(message: appFonts.somethingWentWrong.tr);
                    update();
                  }
        });
        birthdayMessagesGenController.clear();
        birthdayWishGenController.clear();
        nameGenController.clear();
        selectItem = "";
        update();
      }
    }
  }

  endNameSuggestion() {
    dialogLayout.endDialog(
        title: appFonts.endBirthdayMessage,
        subTitle: appFonts.areYouSureEndBirthday,
        onTap: () {
          birthdayMessagesGenController.clear();
          birthdayWishGenController.clear();
          nameGenController.clear();
          textToSpeechCtrl.onStopTTS();
          selectItem = "";
          isBirthdayGenerated = false;
          Get.back();
          update();
        });
  }

  onLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<BirthdayMessageController>(builder: (birthdayCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: birthdayCtrl.langCtrl.translateLanguagesList,
            index: value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, birthdayCtrl.langCtrl.translateLanguagesList);
            },
            scrollController: birthdayCtrl.scrollController,
            onSuggestionSelected: (i) {
              int index = birthdayCtrl.langCtrl.translateLanguagesList
                  .indexWhere((element) {
                return element == i;
              });
              birthdayCtrl.scrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              birthdayCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = birthdayCtrl.langCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              birthdayCtrl.update();
            },
            selectOnTap: () {
              onSelect = selectItem;
              Get.back();
              birthdayCtrl.update();
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
    update();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    birthdayMessagesGenController.clear();
    birthdayWishGenController.clear();
    nameGenController.clear();
    // TODO: implement dispose
    super.dispose();
  }

}
