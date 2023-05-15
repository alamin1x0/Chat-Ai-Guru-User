import '../../../../config.dart';

class CodeGeneratorLayout extends StatelessWidget {
  const CodeGeneratorLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CodeGeneratorController>(builder: (codeGeneratorCtrl) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(appFonts.typeAnythingTo.tr,
            style: AppCss.outfitSemiBold16.textColor(appCtrl.appTheme.primary)),
        const VSpace(Sizes.s15),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(appFonts.selectLanguage.tr,
              style: AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
          const VSpace(Sizes.s8),
          SizedBox(
                  width: double.infinity,
                  child: Text(codeGeneratorCtrl.onSelect ?? "C#",
                          style: AppCss.outfitMedium16
                              .textColor(appCtrl.appTheme.txt))
                      .paddingAll(Insets.i15)
                      .decorated(
                          color: appCtrl.appTheme.textField,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(AppRadius.r8))))
              .inkWell(onTap: () => codeGeneratorCtrl.onSelectLanguageSheet()),
          const VSpace(Sizes.s28),
          InputLayout(
              title: appFonts.writeStuff,
              isMax: true,
              microPhoneTap: () {
                Vibration.vibrate(duration: 200);
                codeGeneratorCtrl.speechToText();
              },
              isAnimated: codeGeneratorCtrl.isListening.value,
              height: codeGeneratorCtrl.isListening.value
                  ? codeGeneratorCtrl.animation!.value
                  : Sizes.s20,
              controller: codeGeneratorCtrl.codeController,
              onTap: () => codeGeneratorCtrl.codeController.clear())
        ])
            .paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i20)
            .authBoxExtension(),
        const VSpace(Sizes.s40),
        ButtonCommon(
            title: appFonts.createMagicalCode,
            onTap: () => codeGeneratorCtrl.onCodeGenerate())
      ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i30);
    });
  }
}
