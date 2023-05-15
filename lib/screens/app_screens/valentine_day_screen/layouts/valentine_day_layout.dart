import '../../../../config.dart';

class ValentineDayLayout extends StatelessWidget {
  const ValentineDayLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ValentineDayController>(builder: (valCtrl) {
      return Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldPrimary16(text: appFonts.wonderfulMessage),
          const VSpace(Sizes.s20),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textCommon.outfitSemiBoldTxt14(text: appFonts.wishesFor),
            const VSpace(Sizes.s10),
            TextFieldCommon(
              hintText: appFonts.enterValue,
              controller: valCtrl.wishForController,
            ),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.name),
            const VSpace(Sizes.s10),
            TextFieldCommon(
              hintText: appFonts.enterValue,
              controller: valCtrl.nameController,
            ),
            const VSpace(Sizes.s20),
            MusicCategoryLayout(
                title: appFonts.messageGenerateIn,
                category: valCtrl.selectItem ?? "English",
                onTap: () => valCtrl.onToLanguageSheet())
          ])
              .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
              .authBoxExtension()
        ]),
        const VSpace(Sizes.s30),
        ButtonCommon(
            title: appFonts.generateGoodWishes,
            onTap: () => valCtrl.onValWishesGenerate()),
        const VSpace(Sizes.s30),
        const AdCommonLayout().backgroundColor(appCtrl.appTheme.error),
      ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}
