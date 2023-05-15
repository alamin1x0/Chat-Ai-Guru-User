import '../../../../config.dart';

class MusicForPostLayout extends StatelessWidget {
  const MusicForPostLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(
      builder: (socialMediaCtrl) {
        return Column(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(appFonts.acquireTheRight.tr,
                style: AppCss.outfitBold16.textColor(appCtrl.appTheme.primary)),
            const VSpace(Sizes.s15),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              MusicCategoryLayout(
                  title: appFonts.selectMusicCategory,
                  category: socialMediaCtrl.categoryOnSelect ?? "Classic",
                  onTap: () => socialMediaCtrl.onSelectMusicCategorySheet()),
              const VSpace(Sizes.s20),
              MusicCategoryLayout(
                  title: appFonts.selectLanguage,
                  category: socialMediaCtrl.onSelect ?? "Hindi",
                  onTap: () => socialMediaCtrl.onSelectLanguageSheet())
            ])
                .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
                .authBoxExtension()
          ]),
          const VSpace(Sizes.s30),
          ButtonCommon(
              title: appFonts.generateSuitableMusic,
              onTap: () => socialMediaCtrl.onMusicGenerate())
        ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
      }
    );
  }
}
