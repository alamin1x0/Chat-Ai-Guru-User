import 'dart:developer';

import 'package:probot/bot_api/api_services.dart';

import '../../config.dart';

class AddApiKeyController extends GetxController {
  TextEditingController apiController = TextEditingController();
  final GlobalKey<FormState> addApiGlobalKey = GlobalKey<FormState>();
 bool isLoader = false;

 List apiNoteLists = [];

  addApiKeyInLocal() {

    isLoader = true;
    update();
    ApiServices.chatCompeletionResponse("ChatGpt",addApiKey: apiController.text).then((value) {
      log("VALUEEE $value");
      if (value != "") {
        appCtrl.storage.write(session.chatGPTKey, apiController.text);
        appCtrl.storage.write(session.isChatGPTKey, true);
        appCtrl.isLocalChatApi = true;
        isLoader = false;

        appCtrl.update();
        Get.forceAppUpdate();
        Get.back();
      } else {
        isLoader = false;
        update();
        snackBarMessengers(
          message: appFonts.invalidApiKey.tr,
        );
      }
    });
  }

  @override
  void onReady() {
    apiNoteLists = appArray.apiNoteList;
    update();
    // TODO: implement onReady
    super.onReady();
  }

}
