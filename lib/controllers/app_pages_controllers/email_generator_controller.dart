import 'package:probot/config.dart';
import 'package:probot/bot_api/api_services.dart';

class EmailGeneratorController extends GetxController {
  TextEditingController topicController = TextEditingController();
  TextEditingController writeFromController = TextEditingController();
  TextEditingController writeToController = TextEditingController();
  TextEditingController generatedMailController = TextEditingController();
  List toneLists = [];
  List mailLengthLists = [];
  int selectIndex = 0;
  double value = 0;
  bool isMailGenerated = false;
  bool isLoader = false;
  String? response = "";

  onGenerateMail() {
    if(topicController.text.isNotEmpty || writeFromController.text.isNotEmpty || writeToController.text.isNotEmpty) {
      int balance = appCtrl.envConfig["balance"];
      if (balance == 0) {
        appCtrl.balanceTopUpDialog();
      } else {
        addCtrl.onInterstitialAdShow();
        isLoader = true;
        ApiServices.chatCompeletionResponse(
            "Write a ${mailLengthLists[selectIndex]} mail to ${writeToController
                .text} from ${writeFromController.text} for ${topicController
                .text} in ${toneLists[selectIndex]} tone")
            .then((value) {
              if (value != "") {
                response = value;
                update();
                isMailGenerated = true;
                isLoader = false;
                update();
              } else {
                isLoader = false;
                snackBarMessengers(message: appFonts.somethingWentWrong.tr);
                update();
              }
        });
        topicController.clear();
        writeFromController.clear();
        writeToController.clear();
        generatedMailController.clear();
        update();
      }
    } else {
      Get.snackbar(appFonts.attention.tr, appFonts.enterTextBoxValue.tr);
    }
  }

  onToneChange(index) {
    selectIndex = index;
    update();
  }

  endEmailGeneratorDialog() {
    dialogLayout.endDialog(
        title: appFonts.endEmailWriter,
        subTitle: appFonts.areYouSureEndEmail,
        onTap: () {
          topicController.clear();
          writeFromController.clear();
          writeToController.clear();
          generatedMailController.clear();
          textToSpeechCtrl.onStopTTS();
          isMailGenerated = false;
          Get.back();
          update();
        });
  }

  @override
  void onReady() {
    addCtrl.onInterstitialAdShow();
    toneLists = appArray.toneList;
    mailLengthLists = appArray.mailLengthList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
  @override
  void dispose() {
    topicController.clear();
    writeFromController.clear();
    writeToController.clear();
    generatedMailController.clear();
    textToSpeechCtrl.onStopTTS();
    // TODO: implement dispose
    super.dispose();
  }

}
