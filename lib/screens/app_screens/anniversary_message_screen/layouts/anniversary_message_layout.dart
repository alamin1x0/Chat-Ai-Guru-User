import '../../../../config.dart';

class AnniversaryMessageLayout extends StatelessWidget {
  const AnniversaryMessageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnniversaryMessageController>(builder: (anniCtrl) {
      return Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldPrimary16(text: appFonts.goodWishesOn),
          const VSpace(Sizes.s20),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MusicCategoryLayout(
                title: appFonts.yearOfAnniversary,
                category: anniCtrl.onSelect ?? "10",
                onTap: () => anniCtrl.onAnniYearSheet()),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.typeOfAnniversary),
            const VSpace(Sizes.s10),
            TextFieldCommon(
              hintText: appFonts.enterValue,
              controller: anniCtrl.typeOfAnniController,
            ),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.relation),
            const VSpace(Sizes.s10),
            TextFieldCommon(
              hintText: appFonts.enterValue,
              controller: anniCtrl.relationController,
            ),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.messageSendTo),
            const VSpace(Sizes.s10),
            TextFieldCommon(
                hintText: appFonts.enterValue,
                controller: anniCtrl.messageSendController),
            const VSpace(Sizes.s20),
            MusicCategoryLayout(
                title: appFonts.messageGenerateIn,
                category: anniCtrl.langOnSelect ?? "English",
                onTap: () => anniCtrl.onLanguageSheet())
          ])
              .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
              .authBoxExtension()
        ]),
        const VSpace(Sizes.s30),
        ButtonCommon(
            title: appFonts.generateGoodWishes,
            onTap: () => anniCtrl.onMessageGenerate())
      ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}
