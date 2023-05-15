import '../../../../config.dart';

class BabyShowerLayout extends StatelessWidget {
  const BabyShowerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BabyShowerController>(builder: (babyShowerCtrl) {
      return Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldPrimary16(text: appFonts.joyfulBabyShower),
          const VSpace(Sizes.s15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textCommon.outfitSemiBoldTxt14(text: appFonts.coupleName),
            const VSpace(Sizes.s10),
            TextFieldCommon(
                hintText: appFonts.enterValue,
                controller: babyShowerCtrl.coupleController),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.relation),
            const VSpace(Sizes.s10),
            TextFieldCommon(
              hintText: appFonts.enterValue,
              controller: babyShowerCtrl.relationController,
            )
          ])
              .paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i20)
              .authBoxExtension()
        ]),
        const VSpace(Sizes.s30),
        ButtonCommon(
            title: appFonts.generateLovelyMessage,
            onTap: () => babyShowerCtrl.onWishesGenerate()),
        const VSpace(Sizes.s30),
        const AdCommonLayout().backgroundColor(appCtrl.appTheme.error),
      ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}
