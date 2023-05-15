import '../../../../config.dart';

class MothersDayWishesLayout extends StatelessWidget {
  const MothersDayWishesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MothersDayWishesController>(builder: (motherDayCtrl) {
      return Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldPrimary16(text: appFonts.greetingForMother),
          const VSpace(Sizes.s15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textCommon.outfitSemiBoldTxt14(text: appFonts.mothersName),
            const VSpace(Sizes.s10),
            TextFieldCommon(
              hintText: appFonts.enterValue,
              controller: motherDayCtrl.motherController,
            ),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.relation),
            const VSpace(Sizes.s10),
            TextFieldCommon(
              hintText: appFonts.enterValue,
              controller: motherDayCtrl.relationController,
            )
          ])
              .paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i20)
              .authBoxExtension()
        ]),
        const VSpace(Sizes.s30),
        ButtonCommon(
            title: appFonts.generateBeautifulWish,
            onTap: () => motherDayCtrl.onWishesGenerate()),
        const VSpace(Sizes.s30),
        const AdCommonLayout().backgroundColor(appCtrl.appTheme.error),
      ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}
