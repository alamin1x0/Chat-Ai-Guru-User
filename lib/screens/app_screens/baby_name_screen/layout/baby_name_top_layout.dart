import '../../../../config.dart';

class BabyNameTopLayout extends StatelessWidget {
  const BabyNameTopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BabyNameSuggestionController>(builder: (babyCtrl) {
      return Column(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldPrimary16(text: appFonts.getLatestNames),
          const VSpace(Sizes.s15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            textCommon.outfitSemiBoldTxt14(text: appFonts.selectGender),
            const VSpace(Sizes.s10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: babyCtrl.genderLists
                    .asMap()
                    .entries
                    .map((e) => SelectGenderLayout(
                        data: e.value,
                        index: e.key,
                        selectedIndex: babyCtrl.selectedIndex,
                        onTap: () => babyCtrl.onGenderChange(e.key)))
                    .toList()),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.nameSuggestion),
            const VSpace(Sizes.s10),
            Row(
                children: babyCtrl.nameSuggestionLists
                    .asMap()
                    .entries
                    .map((e) => PasswordRadioButtonLayout(
                            data: e.value,
                            index: e.key,
                            selectIndex: babyCtrl.selectedNameIndex,
                            onTap: () => babyCtrl.onNameSuggestionChange(e.key))
                        .paddingOnly(
                            right: appCtrl.isRTL ? 0 : Insets.i50,
                            left: appCtrl.isRTL ? Insets.i50 : 0))
                    .toList()),
            const VSpace(Sizes.s5),
            babyCtrl.selectedNameIndex == 0
                ? MusicCategoryLayout(
                    title: appFonts.selectZodiac,
                    category: babyCtrl.selectItem ?? "Capricorn",
                    onTap: () => babyCtrl.onZodiacSheet())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        textCommon.outfitSemiBoldTxt14(
                            text: appFonts.enterFirstLetter),
                        const VSpace(Sizes.s10),
                        TextFieldCommon(
                            hintText: appFonts.enterFirstLetter,
                            controller: babyCtrl.latterController)
                      ])
          ])
              .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
              .authBoxExtension()
        ]),
        ButtonCommon(
                title: appFonts.suggestMeTheLovelyName,
                onTap: () => babyCtrl.onNameGenerate())
            .paddingSymmetric(vertical: Insets.i30),
        const AdCommonLayout().backgroundColor(appCtrl.appTheme.error)
      ]);
    });
  }
}
