

import '../../config.dart';

class ManageApiController extends GetxController {
  TextEditingController manageApiController = TextEditingController();

  onRemoveKey() {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return AlertDialogCommon(
              image: eImageAssets.success,
              bText1: appFonts.okay,
              title: appFonts.apiKeyRemoved,
              subtext: appFonts.yourApiKey,
              b1OnTap: () {
                appCtrl.storage.remove(session.chatGPTKey);
                appCtrl.storage.write(session.isChatGPTKey, false);
                appCtrl.isLocalChatApi = false;
                appCtrl.update();
                manageApiController.clear();
                Get.forceAppUpdate();
                Get.back();
                Get.back();
              },
              crossOnTap: () {
                appCtrl.storage.remove(session.chatGPTKey);
                appCtrl.storage.write(session.isChatGPTKey, false);
                appCtrl.isLocalChatApi = false;
                appCtrl.update();
                manageApiController.clear();
                Get.forceAppUpdate();
                Get.back();
                Get.back();
              });
        });
  }

  @override
  void onReady() {
    if(appCtrl.isLocalChatApi){
      manageApiController.text = appCtrl.storage.read(session.chatGPTKey);
    } else {
      manageApiController.text = '';
    }
    // TODO: implement onReady
    super.onReady();
  }

}