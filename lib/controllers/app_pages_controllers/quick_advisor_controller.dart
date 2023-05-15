import 'dart:developer';

import 'package:probot/config.dart';

class QuickAdvisorController extends GetxController {
  List quickAdvisorLists = [];
  List favoriteDataList = [];
  int? selectedIndex;
  int? selectedIndexRemove;
  bool isFav = true;
  dynamic favDex;
  dynamic favRemoveDex;

  onTapAddFavorite(index) {
    selectedIndex = index;
    favoriteDataList.add(quickAdvisorLists[index]);
    quickAdvisorLists
        .removeWhere((element) => element == quickAdvisorLists[index]);
    selectedIndex = null;
    appCtrl.storage.write("fav", index);
    /*quickAdvisorLists.remove(favoriteDataList[index]);*/
    update();
  }

  onTapRemoveFavorite(index) {
    selectedIndexRemove = index;
    quickAdvisorLists.add(favoriteDataList[index]);
    favoriteDataList.remove(favoriteDataList[index]);
    appCtrl.storage.write("removeFav", index);
    update();
  }

  final homeCtrl = Get.isRegistered<Home>()
      ? Get.find<AppController>()
      : Get.put(AppController());

  @override
  void onReady() {
    List<dynamic> list = appCtrl.storage.read("quickList") ?? [];
    List<dynamic> favList = appCtrl.storage.read("favList") ?? [];
    dynamic fav = appCtrl.storage.read("fav") ?? 0;
    dynamic removeFavorite = appCtrl.storage.read("removeFav") ?? 0;
    favDex = fav;
    favRemoveDex = removeFavorite;
    log("=============================$fav");
    log("==============++++++===============$favRemoveDex");
    log("LIST $list");
    log("FAV LIST $favList");

    if (list.isEmpty) {
      log("LIST EMPTY $list");
      appCtrl.storage.write("quickList", appArray.quickAdvisor);
    }
    if (favList.isEmpty) {
      log("FAV LIST EMPTY $favList");
      appCtrl.storage.write("favList", favoriteDataList);
    }

    favoriteDataList = appCtrl.storage.read("favList");

    update();
    // TODO: implement onReady
    super.onReady();
  }

  getQuickData() async {
    quickAdvisorLists = [];
    List quickLists = appCtrl.storage.read("quickList");
    quickLists.asMap().entries.forEach((element) {
      log("TITLE : ${element.value["title"] }");
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
      if (element.value["title"] == "content" || element.value["title"] == "Content") {
        if (appCtrl.categoryAccessModel!.isContentWritingEnable!) {
          quickAdvisorLists.add(element.value);
        }
      }
    });
  }
}
