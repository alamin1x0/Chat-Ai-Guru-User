import '../../../../config.dart';

class WithoutCaptionLayout extends StatelessWidget {
  const WithoutCaptionLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        textCommon.outfitSemiBoldTxt14(text: appFonts.fillUpTheForm.tr),
        const VSpace(Sizes.s15),
        SizedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              textCommon.outfitSemiBoldTxt14(text: appFonts.selectPlatform.tr),
              const VSpace(Sizes.s10),
              Wrap(
                  children: socialMediaCtrl.captionCreatorLists
                      .asMap()
                      .entries
                      .map((e) => PlatformLayout(
                              data: e.value,
                              index: e.key,
                              selectedIndex: socialMediaCtrl.selectedIndex,
                              onTap: () =>
                                  socialMediaCtrl.onPlatformChange(e.key))
                          .paddingOnly(bottom: Insets.i10, right: Insets.i10))
                      .toList()),
              const VSpace(Sizes.s28),
              InputLayout(
                  hintText: appFonts.typeHere,
                  title: appFonts.writeDetail,
                  isMax: true,
                  isAnimated: socialMediaCtrl.isListening.value,
                  height: socialMediaCtrl.isListening.value
                      ? socialMediaCtrl.animation!.value
                      : Sizes.s20,
                  microPhoneTap: () => socialMediaCtrl.onStopSTT(),
                  controller: socialMediaCtrl.captionController,
                  onTap: () => socialMediaCtrl.captionController.clear()),
              const VSpace(Sizes.s20),
              textCommon.outfitSemiBoldTxt14(
                  text: appFonts.targetedAudience.tr),
              const TargetAudienceSliderLayout(),
              textCommon.outfitSemiBoldTxt14(text: appFonts.captionTone.tr),
              const VSpace(Sizes.s10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: socialMediaCtrl.captionToneLists
                      .asMap()
                      .entries
                      .map((e) => CaptionToneLayout(
                          data: e.value,
                          index: e.key,
                          selectedIndex: socialMediaCtrl.selectedIndexTone,
                          onTap: () =>
                              socialMediaCtrl.onCaptionToneChange(e.key)))
                      .toList())
            ]))
            .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
            .authBoxExtension(),
        const VSpace(Sizes.s30),
        ButtonCommon(
            title: appFonts.bringMeTheBest,
            onTap: () => socialMediaCtrl.onCaptionGenerate())
      ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}
