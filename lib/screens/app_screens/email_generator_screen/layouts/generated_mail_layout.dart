import '../../../../config.dart';

class GeneratedMailLayout extends StatelessWidget {
  const GeneratedMailLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailGeneratorController>(builder: (emailGeneratorCtrl) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              textCommon.outfitSemiBoldPrimary16(
                  text: appFonts.toGetTheExcellent.tr),
              const VSpace(Sizes.s15),
              SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    EmailGeneratorTopLayout(
                        fTitle: appFonts.writeFrom,
                        fHint: appFonts.enterValue,
                        fController: emailGeneratorCtrl.writeFromController,
                        sTitle: appFonts.writeTo,
                        sHint: appFonts.enterValue,
                        sController: emailGeneratorCtrl.writeToController),
                    const VSpace(Sizes.s20),
                    textCommon.outfitSemiBoldTxt14(text: appFonts.topic.tr),
                    const VSpace(Sizes.s10),
                    TextFieldCommon(
                        controller: emailGeneratorCtrl.topicController,
                        hintText: appFonts.typeHere,
                        minLines: 8,
                        maxLines: 8,
                        fillColor: appCtrl.appTheme.textField,
                        keyboardType: TextInputType.multiline),
                    const VSpace(Sizes.s20),
                    textCommon.outfitSemiBoldTxt14(text: appFonts.tone.tr),
                    Wrap(
                        children: emailGeneratorCtrl.toneLists
                            .asMap()
                            .entries
                            .map((e) => ToneLayout(
                                title: e.value,
                                index: e.key,
                                selectedIndex: emailGeneratorCtrl.selectIndex,
                                onTap: () => emailGeneratorCtrl
                                    .onToneChange(e.key)).paddingOnly(
                                top: Insets.i10, right: Insets.i10))
                            .toList()),
                    const VSpace(Sizes.s20),
                    textCommon.outfitSemiBoldTxt14(
                        text: appFonts.mailLength.tr),
                    const VSpace(Sizes.s20),
                    const SliderLayout(),
                    const VSpace(Sizes.s20),
                    const MailLengthLayout()
                  ]))
                  .paddingSymmetric(
                      horizontal: Insets.i15, vertical: Insets.i20)
                  .authBoxExtension()
            ]),
            const VSpace(Sizes.s30),
            ButtonCommon(
                title: appFonts.myFitnessMail,
                onTap: () => emailGeneratorCtrl.onGenerateMail())
          ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}
