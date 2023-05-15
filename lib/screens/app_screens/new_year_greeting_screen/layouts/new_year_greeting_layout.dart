import '../../../../config.dart';

class NewYearGreetingLayout extends StatelessWidget {
  const NewYearGreetingLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewYearGreetingController>(builder: (newYearCtrl) {
      return Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldPrimary16(text: appFonts.aFreshStart),
          const VSpace(Sizes.s15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textCommon.outfitSemiBoldTxt14(text: appFonts.year),
            const VSpace(Sizes.s10),
            TextFieldCommon(
                hintText: appFonts.enterValue,
                controller: newYearCtrl.yearController),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.sendWishesTo),
            const VSpace(Sizes.s10),
            TextFieldCommon(
                hintText: appFonts.enterValue,
                controller: newYearCtrl.sendWishesController),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.name),
            const VSpace(Sizes.s10),
            TextFieldCommon(
                hintText: appFonts.enterValue,
                controller: newYearCtrl.nameController),
            const VSpace(Sizes.s20),
            MusicCategoryLayout(
                title: appFonts.wishGenerateIn,
                category: newYearCtrl.selectItem ?? "English",
                onTap: () => newYearCtrl.onLanguageSheet())
          ])
              .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
              .authBoxExtension()
        ]),
        const VSpace(Sizes.s30),
        ButtonCommon(
            title: appFonts.createSpectacular,
            onTap: () => newYearCtrl.onNewYearWishesGenerate()),
        const VSpace(Sizes.s30),
        const AdCommonLayout().backgroundColor(appCtrl.appTheme.error)
      ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i30);
    });
  }
}
