

import '../../../../config.dart';

class EssayGenerateLayout extends StatelessWidget {
  const EssayGenerateLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EssayWriterController>(builder: (essayWriterCtrl) {
      return Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldPrimary16(text: appFonts.getAnExceptional),
          const VSpace(Sizes.s15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            InputLayout(
                hintText: appFonts.writeTheEssay,
                title: appFonts.subjectOfTheEssay,
                isMax: true,
                isAnimated: essayWriterCtrl.isListening.value,
                height: essayWriterCtrl.isListening.value
                    ? essayWriterCtrl.animation!.value
                    : Sizes.s20,
                microPhoneTap: () {
                  Vibration.vibrate(duration: 200);
                  essayWriterCtrl.speechToText();
                },
                controller: essayWriterCtrl.essayController,
                onTap: () => essayWriterCtrl.essayController.clear()),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.essayType),
            const VSpace(Sizes.s10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: essayWriterCtrl.essayTypeLists
                    .asMap()
                    .entries
                    .map((e) => PasswordRadioButtonLayout(
                        data: e.value,
                        index: e.key,
                        selectIndex: essayWriterCtrl.selectedIndex,
                        onTap: () => essayWriterCtrl.onEssayTypeChange(e.key)))
                    .toList())
          ])
              .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
              .authBoxExtension()
        ]),
        const VSpace(Sizes.s30),
        ButtonCommon(
            title: appFonts.startEssayWriting,
            onTap: () => essayWriterCtrl.onEssayGenerated()),
        const VSpace(Sizes.s30),
        const AdCommonLayout().backgroundColor(appCtrl.appTheme.error),
      ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i30);
    });
  }
}
