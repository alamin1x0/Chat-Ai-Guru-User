import '../../../../config.dart';

class GenerateWishesLayout extends StatelessWidget {
  const GenerateWishesLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BirthdayMessageController>(
      builder: (birthdayCtrl) {
        return Column(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textCommon.outfitSemiBoldPrimary16(text: appFonts.aSpecialDay),
            const VSpace(Sizes.s15),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              textCommon.outfitSemiBoldTxt14(text: appFonts.sendBirthdayWishes),
              const VSpace(Sizes.s10),
              TextFieldCommon(
                  hintText: appFonts.enterValue,
                  controller: birthdayCtrl.birthdayWishGenController),
              const VSpace(Sizes.s20),
              textCommon.outfitSemiBoldTxt14(text: appFonts.name),
              const VSpace(Sizes.s10),
              TextFieldCommon(
                  hintText: appFonts.enterValue,
                  controller: birthdayCtrl.nameGenController),
              const VSpace(Sizes.s20),
              MusicCategoryLayout(
                  title: appFonts.messageGenerateIn,
                  category: birthdayCtrl.selectItem ?? "Hindi",
                  onTap: () => birthdayCtrl.onLanguageSheet())
            ])
                .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
                .authBoxExtension(),
            const VSpace(Sizes.s30),
            ButtonCommon(
                title: appFonts.generateGoodWishes,
                onTap: () => birthdayCtrl.onTapWishesGenerate()),
            const VSpace(Sizes.s30),
            const AdCommonLayout().backgroundColor(appCtrl.appTheme.error)
          ])
        ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
      }
    );
  }
}
