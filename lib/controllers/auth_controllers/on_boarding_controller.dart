import '../../config.dart';

class OnBoardingController extends GetxController {
   PageController pageCtrl = PageController();
  List onBoardingLists = [];
   List<SelectLanguageModel> selectLanguageLists = [];
  bool isLastPage = false;
  int selectIndex = 0;
   String langValue = appFonts.english;

   //on language select
   onLanguageSelectTap(SelectLanguageModel data)async{
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
     }else if (data.code == "ja") {
       appCtrl.languageVal = "ja";
     }

     appCtrl.update();
     await appCtrl.storage
         .write(session.locale, data.code);

     update();
     appCtrl.update();
     Get.updateLocale(data.locale!);
     Get.forceAppUpdate();
   }

   @override
  void onReady() {
     selectLanguageLists = appArray.languagesList
         .map((e) => SelectLanguageModel.fromJson(e))
         .toList();
     onBoardingLists = appArray.onBoardingList;
     update();
    // TODO: implement onReady
    super.onReady();
  }
}