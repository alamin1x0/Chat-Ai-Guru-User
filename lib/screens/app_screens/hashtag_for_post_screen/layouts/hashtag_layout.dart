import '../../../../config.dart';

class HashtagLayout extends StatelessWidget {
  const HashtagLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(appFonts.fillBelowToRight.tr,
            style: AppCss.outfitBold16.textColor(appCtrl.appTheme.primary)),
        const VSpace(Sizes.s15),
        Column(children: [
          InputLayout(
              hintText: appFonts.typeHere,
              title: appFonts.describeYourPost,
              microPhoneTap: () {
                Vibration.vibrate(duration: 200);
                socialMediaCtrl.speechToText();
              },
              isAnimated: socialMediaCtrl.isListening.value,
              height: socialMediaCtrl.isListening.value
                  ? socialMediaCtrl.animation!.value
                  : Sizes.s20,
              isMax: true,
              controller: socialMediaCtrl.hashtagController,
              onTap: () => socialMediaCtrl.hashtagController.clear())
        ])
            .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
            .authBoxExtension(),
        const VSpace(Sizes.s30),
        if (socialMediaCtrl.isHashtagGenerated != true)
          ButtonCommon(
              title: appFonts.buildSomeMagic,
              onTap: () => socialMediaCtrl.onHashtagGenerate()),
        const AdCommonLayout()
      ]);
    });
  }
}
