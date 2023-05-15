import '../../../../config.dart';

class PromotionWishesLayout extends StatelessWidget {
  const PromotionWishesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromotionWishesController>(builder: (promotionCtrl) {
      return Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldPrimary16(text: appFonts.aspiresToAdvance),
          const VSpace(Sizes.s15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textCommon.outfitSemiBoldTxt14(text: appFonts.name),
            const VSpace(Sizes.s10),
            TextFieldCommon(
                hintText: appFonts.enterValue,
                controller: promotionCtrl.nameController),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.relation),
            const VSpace(Sizes.s10),
            TextFieldCommon(
                hintText: appFonts.enterValue,
                controller: promotionCtrl.relationController)
          ])
              .paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i20)
              .authBoxExtension()
        ]),
        const VSpace(Sizes.s30),
        ButtonCommon(
            title: appFonts.generateLovelyMessage,
            onTap: () => promotionCtrl.onWishesGenerate()),
        const VSpace(Sizes.s30),
        const AdCommonLayout().backgroundColor(appCtrl.appTheme.error),
      ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}
