import '../../config.dart';

class TextToSpeechController extends GetxController {
  final FlutterTts? flutterTts = FlutterTts();
  final _isSpeech = false.obs;
  final _isSpeechLoading = false.obs;

  String code = appCtrl.languageVal == "en"
      ? "US"
      : appCtrl.languageVal == "fr"
      ? "CA"
      : appCtrl.languageVal == "ge"
      ? "GE"
      : appCtrl.languageVal == "hi"
      ? "IN"
      : appCtrl.languageVal ==
      "it"
      ? "IT"
      : appCtrl.languageVal ==
      "ja"
      ? "JP"
      : "US";

  //speech method
  speechMethod(String text) async {
    _isSpeechLoading.value = true;
    _isSpeech.value = true;
    update();

    await flutterTts!.setLanguage('${appCtrl.languageVal}-$code');
    await flutterTts!.setPitch(1);
    await flutterTts!.setSpeechRate(0.45);
    await flutterTts!.speak(text);

    Future.delayed(
        const Duration(seconds: 2), () => _isSpeechLoading.value = false);
    update();
  }

  onStopTTS() {
    flutterTts!.stop();
    Get.back();
    update();
  }

  @override
  void dispose() {
    flutterTts!.stop();
    update();
    // TODO: implement dispose
    super.dispose();
  }

}