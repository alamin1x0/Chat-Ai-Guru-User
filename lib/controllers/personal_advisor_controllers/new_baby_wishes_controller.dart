import 'dart:developer';

import 'package:probot/bot_api/api_services.dart';
import 'package:probot/config.dart';

class NewBabyWishesController extends GetxController {
  final FixedExtentScrollController? languageScrollController =
      FixedExtentScrollController();

  TextEditingController wishGenController = TextEditingController();
  TextEditingController babyController = TextEditingController();
  TextEditingController relationGenController = TextEditingController();
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();

  final langCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());

  List genderLists = [];
  int selectIndex = 0;
  int langValue = 0;
  String? langSelectItem;
  String? langOnSelect;
  String? response;
  bool isWishGenerate = false;
  bool isLoader = false;

  onWishesGenerate() {
    if(scaffoldKey.currentState!.validate()) {
      int balance = appCtrl.envConfig["balance"];
      if(balance == 0){
        appCtrl.balanceTopUpDialog();
      }else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "suggest new born baby ${genderLists[selectIndex]['title']} ${babyController
                .text} message from ${relationGenController
                .text} in $langOnSelect").then((value) {
                  if (value != "") {
                    response = value;
                    update();
                    isWishGenerate = true;
                    isLoader = false;
                    update();
                  } else {
                    isLoader = false;
                    snackBarMessengers(message: appFonts.somethingWentWrong.tr);
                    update();
                  }
        });
        babyController.clear();
        relationGenController.clear();
        langSelectItem = '';
        update();
      }}
  }

  onGenderChange(index) {
    selectIndex = index;
    update();
  }

  endBabyWishesSuggestion() {
    dialogLayout.endDialog(
        title: appFonts.endBornBabyWish,
        subTitle: appFonts.areYouSureEndBabyName,
        onTap: () {
          babyController.clear();
          relationGenController.clear();
          langSelectItem = '';
          textToSpeechCtrl.onStopTTS();
          isWishGenerate = false;
          Get.back();
          update();
        });
  }

  onLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<NewBabyWishesController>(builder: (newCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: newCtrl.langCtrl.translateLanguagesList,
            index: langValue,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, newCtrl.langCtrl.translateLanguagesList);
            },
            scrollController: newCtrl.languageScrollController,
            onSuggestionSelected: (i) {
              int index =
                  newCtrl.langCtrl.translateLanguagesList.indexWhere((element) {
                return element == i;
              });
              newCtrl.languageScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              newCtrl.update();
            },
            onSelectedItemChanged: (i) {
              langValue = i;
              langSelectItem = newCtrl.langCtrl.translateLanguagesList[i];

              update();
              newCtrl.update();
            },
            selectOnTap: () {
              langOnSelect = langSelectItem;
              Get.back();
              newCtrl.update();
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
    genderLists = appArray.genderList;
    update();
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void dispose() {
    babyController.clear();
    relationGenController.clear();
    langSelectItem = '';
    textToSpeechCtrl.onStopTTS();
    isWishGenerate = false;
    // TODO: implement dispose
    super.dispose();
  }
}
