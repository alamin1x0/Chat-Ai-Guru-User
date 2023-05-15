import '../../../../config.dart';

class WithoutTranslateLayout extends StatelessWidget {
  const WithoutTranslateLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TranslateController>(builder: (translateCtrl) {
      return Column(children: [
        TranslationLayout(
            from: translateCtrl.onFromSelect ?? appFonts.english,
            to: translateCtrl.onToSelect ?? appFonts.hindi,
            fromOnTap: () => translateCtrl.onFromLanguageSheet(),
            toOnTap: () => translateCtrl.onToLanguageSheet()),
        const VSpace(Sizes.s25),
        InputLayout(
            title: appFonts.englishTyping,
            isMax: true,
            controller: translateCtrl.transController,
            microPhoneTap: () {
              Vibration.vibrate(duration: 200);
              translateCtrl.speechToText();
            },
            isAnimated: translateCtrl.isListening.value,
            height: translateCtrl.isListening.value
                ? translateCtrl.animation!.value
                : Sizes.s20,
            onTap: () => translateCtrl.transController.clear())
      ])
          .paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i20)
          .authBoxExtension();
    });
  }
}
