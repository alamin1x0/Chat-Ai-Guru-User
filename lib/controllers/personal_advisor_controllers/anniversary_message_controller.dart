import 'dart:developer';

import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class AnniversaryMessageController extends GetxController {
  List<String> anniversaryYearList =
      List<String>.generate(70, (counter) => "${counter + 1}");
  final FixedExtentScrollController? anniYearScrollController =
      FixedExtentScrollController();
  final FixedExtentScrollController? languageScrollController =
      FixedExtentScrollController();
  TextEditingController wishGenController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController typeOfAnniController = TextEditingController();
  TextEditingController messageSendController = TextEditingController();
  final GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();

  int value = 0;
  int langValue = 0;
  String? selectItem;
  String? langSelectItem;
  String? onSelect;
  String? langOnSelect;
  bool isMessageGenerate = false;
  bool isLoader = false;
  String? response;

  final langCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());

  onMessageGenerate() {
    if(scaffoldKey.currentState!.validate()) {
      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "I want to write ${typeOfAnniController
                .text} anniversary wish to ${messageSendController
                .text}  for ${selectItem ??
                "10"} years of togetherness in ${relationController.text}")
            .then((value) {
              if (value != "") {
                response = value;
                update();
                isMessageGenerate = true;
                isLoader = false;
                update();
              } else {
                isLoader = false;
                snackBarMessengers(message: appFonts.somethingWentWrong.tr);
                update();
              }
        });
        wishGenController.clear();
        relationController.clear();
        typeOfAnniController.clear();
        messageSendController.clear();
        selectItem = "";
        langSelectItem = '';
        update();
      }
    } else {
      log("LOGGGGG");
    }
  }

  endNameSuggestion() {
    dialogLayout.endDialog(
        title: appFonts.endAnniversaryMessage,
        subTitle: appFonts.areYouSureEndAnniversary,
        onTap: () {
          wishGenController.clear();
          relationController.clear();
          typeOfAnniController.clear();
          messageSendController.clear();
          textToSpeechCtrl.onStopTTS();
          selectItem = "";
          langSelectItem = '';
          isMessageGenerate = false;
          Get.back();
          update();
        });
  }

  onLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<AnniversaryMessageController>(builder: (anniCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: anniCtrl.langCtrl.translateLanguagesList,
            index: langValue,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, anniCtrl.langCtrl.translateLanguagesList);
            },
            scrollController: anniCtrl.languageScrollController,
            onSuggestionSelected: (i) {
              int index = anniCtrl.langCtrl.translateLanguagesList
                  .indexWhere((element) {
                return element == i;
              });
              anniCtrl.languageScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              anniCtrl.update();
            },
            onSelectedItemChanged: (i) {
              langValue = i;
              langSelectItem = anniCtrl.langCtrl.translateLanguagesList[i];
              log("SELECT ITEM: $selectItem");
              update();
              anniCtrl.update();
            },
            selectOnTap: () {
              langOnSelect = langSelectItem;
              Get.back();
              anniCtrl.update();
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

  onAnniYearSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<AnniversaryMessageController>(builder: (anniCtrl) {
          return LanguagePickerLayout(
            title: appFonts.selectLanguage,
            list: anniCtrl.anniversaryYearList,
            index: value,
            suggestionsCallbacks: (value) {
              return StateService.getSuggestions(
                  value, anniCtrl.anniversaryYearList);
            },
            scrollController: anniCtrl.anniYearScrollController,
            onSuggestionSelected: (i) {
              int index = anniCtrl.anniversaryYearList.indexWhere((element) {
                return element == i;
              });
              anniCtrl.anniYearScrollController!.jumpToItem(index);
              log("suggestion: $i");
              log("index: $index");
              update();
              anniCtrl.update();
            },
            onSelectedItemChanged: (i) {
              value = i;
              selectItem = anniCtrl.anniversaryYearList[i];
              log("SELECT ITEM: $selectItem");
              update();
              anniCtrl.update();
            },
            selectOnTap: () {
              onSelect = selectItem;
              Get.back();
              anniCtrl.update();
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
  void dispose() {
    wishGenController.clear();
    relationController.clear();
    typeOfAnniController.clear();
    messageSendController.clear();
    selectItem = "";
    langSelectItem = '';
    // TODO: implement dispose
    super.dispose();
  }

}
