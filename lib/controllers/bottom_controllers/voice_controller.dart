import 'dart:developer';
import '../../config.dart';

class VoiceController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final isListening = false.obs;
  SpeechToText speech = SpeechToText();

  //speech to text
  void speechToText() async {
    int balance = appCtrl.envConfig["balance"];
    log("BALANCE: $balance");
    if (balance == 0) {
      appCtrl.balanceTopUpDialog();
      update();
    } else {
      log("ISLISTEN : ${isListening.value}");
      if (isListening.value == false) {
        bool available = await speech.initialize(
          onStatus: (val) {
            debugPrint('*** onStatus: $val');
            log("loo : ${val == "done"}");
            if (val == "done" || val == "notListening") {
              isListening.value = false;
              update();
            }
            Get.forceAppUpdate();
          },
          onError: (val) {
            debugPrint('### onError: $val');
          },
        );
        log("available ; $available");
        if (available) {
          isListening.value = true;
          speech.listen(
            localeId: appCtrl.languageVal,
            onResult: (val) {
              log("VAL : ${val.recognizedWords.toString()}");
              if (isListening.value == false) {
                if (val.recognizedWords.isNotEmpty) {
                  log("+++++++++++++++++++++++++++++++++${val.recognizedWords.toString()}");
                  Get.toNamed(routeName.chatLayout, arguments: {
                    "speechText": val.recognizedWords.toString()
                  });
                  final chatCtrl = Get.isRegistered<ChatLayoutController>()
                      ? Get.find<ChatLayoutController>()
                      : Get.put(ChatLayoutController());
                  chatCtrl.chatController.text = val.recognizedWords.toString();
                  chatCtrl.textInput.value = val.recognizedWords.toString();
                  chatCtrl.getChatId();
                  update();
                }
                update();
              }
            },
            cancelOnError: true,
          );

          update();
        } else {
          log("NO");
        }
      } else {
        isListening.value = false;
        update();
      }
    }
  }

  @override
  void onReady() {
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
