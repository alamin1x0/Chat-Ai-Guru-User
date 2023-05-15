import 'dart:developer';

import '../../config.dart';

class SelectLanguageController extends GetxController {
  List selectLanguageLists = [];
  int selectIndex = 0;
  bool isBack = false;

  //on language select tap
  onLanguageChange(index) {
    selectIndex = index;
    update();
  }

  // continue button tap
  onContinue() async {
    appCtrl.isLanguage = true;
    await appCtrl.storage.write(session.isLanguage, appCtrl.isLanguage);
    if(isBack){
      Get.back();
    }else {
      Get.toNamed(routeName.dashboard);
    }
    update();
  }

  @override
  void onReady() async {
    isBack = Get.arguments ?? false;
    var index = await appCtrl.storage.read("index") ?? 0;
    selectIndex = index;
    selectLanguageLists = appArray.languagesList
        .map((e) => SelectLanguageModel.fromJson(e))
        .toList();
    update();
    log("isBack : $isBack");
    // TODO: implement onReady
    super.onReady();
  }

  //on language select
  onLanguageSelectTap(index,SelectLanguageModel data)async{
    selectIndex =index;
    if (data.code == "en") {
      appCtrl.languageVal = "en";
    } else if (data.code == "hi") {
      appCtrl.languageVal = "hi";
    } else if (data.code == "ar") {
      appCtrl.languageVal = "ar";
    } else if (data.code == "fr") {
      appCtrl.languageVal = "fr";
    }else if (data.code == "it") {
      appCtrl.languageVal = "it";
    }else if (data.code == "ge") {
      appCtrl.languageVal = "ge";
    }

    appCtrl.update();
    await appCtrl.storage
        .write("index", selectIndex);
    await appCtrl.storage
        .write(session.locale, data.code);

    update();
    appCtrl.update();
    Get.updateLocale(data.locale!);
    Get.forceAppUpdate();
  }
}
