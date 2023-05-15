import '../../../../config.dart';

class WithoutGenerateResponseLayout extends StatelessWidget {
  const WithoutGenerateResponseLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GiftSuggestionController>(builder: (giftSuggestionCtrl) {
      return Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldPrimary16(text: appFonts.discoverIncredible),
          const VSpace(Sizes.s15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textCommon.outfitSemiBoldTxt14(text: appFonts.sendGiftTo),
            const VSpace(Sizes.s10),
            TextFieldCommon(
                hintText: appFonts.enterValue,
                controller: giftSuggestionCtrl.sendGiftController),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.occasion),
            const VSpace(Sizes.s10),
            TextFieldCommon(
                hintText: appFonts.enterValue,
                controller: giftSuggestionCtrl.occasionController)
          ])
              .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
              .authBoxExtension()
        ]),
        ButtonCommon(
                title: appFonts.generateTheBeautiful,
                onTap: () => giftSuggestionCtrl.onGiftSuggestionGenerate())
            .paddingOnly(top: Insets.i30),
        const VSpace(Sizes.s30),
        const AdCommonLayout().backgroundColor(appCtrl.appTheme.error)
      ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}
