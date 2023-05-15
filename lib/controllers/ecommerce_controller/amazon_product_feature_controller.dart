import 'dart:developer';

import '../../config.dart';

class AmazonProductFeatureController extends GetxController {
  TextEditingController productController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController maxWordController = TextEditingController();

  String? response = '';
  bool isProductGenerated = false;

  onProductGenerated() {
    isProductGenerated = true;
    update();
  }

  final FixedExtentScrollController? scrollController =
      FixedExtentScrollController();
  int value = 0;
  String? selectItem;
  String? onSelect;
  final langCtrl = Get.isRegistered<TranslateController>()
      ? Get.find<TranslateController>()
      : Get.put(TranslateController());

  onLanguageSheet() {
    Get.bottomSheet(
      isScrollControlled: true,
      backgroundColor: appCtrl.appTheme.white,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return GetBuilder<AmazonProductFeatureController>(
            builder: (amazonCtrl) {
          return LanguagePickerLayout(
              title: appFonts.selectLanguage,
              list: amazonCtrl.langCtrl.translateLanguagesList,
              index: value,
              suggestionsCallbacks: (value) {
                return StateService.getSuggestions(
                    value, amazonCtrl.langCtrl.translateLanguagesList);
              },
              scrollController: amazonCtrl.scrollController,
              onSuggestionSelected: (i) {
                int index = amazonCtrl.langCtrl.translateLanguagesList
                    .indexWhere((element) {
                  return element == i;
                });
                amazonCtrl.scrollController!.jumpToItem(index);
                log("suggestion: $i");
                log("index: $index");
                update();
                amazonCtrl.update();
              },
              onSelectedItemChanged: (i) {
                value = i;
                selectItem = amazonCtrl.langCtrl.translateLanguagesList[i];
                log("SELECT ITEM: $selectItem");
                update();
                amazonCtrl.update();
              },
              selectOnTap: () {
                onSelect = selectItem;
                Get.back();
                amazonCtrl.update();
              });
        });
      }),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(AppRadius.r10),
              topLeft: Radius.circular(AppRadius.r10))),
    );
  }

  endNameSuggestion() {
    dialogLayout.endDialog(
        title: appFonts.endProduct,
        subTitle: appFonts.areYouSureEndFeature,
        onTap: () {
          isProductGenerated = false;
          Get.back();
          update();
        });
  }

}
