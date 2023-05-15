import '../../../config.dart';

class MusicForPostScreen extends StatelessWidget {
  const MusicForPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return WillPopScope(
          onWillPop: () => socialMediaCtrl.onClear(),
          child: DirectionalityRtl(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppAppBarCommon(
                      title: appFonts.musicForPost,
                      leadingOnTap: () => socialMediaCtrl.onClear()),
                  body: Stack(children: [
                    SingleChildScrollView(
                        child: socialMediaCtrl.isMusicGenerated == true
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(appFonts.highestQuality.tr,
                                              style: AppCss.outfitBold16
                                                  .textColor(appCtrl
                                                      .appTheme.primary)),
                                          const VSpace(Sizes.s15),
                                          InputLayout(
                                              hintText: appFonts.typeHere,
                                              title: appFonts.musicSuggestion,
                                              isMax: false,
                                              color: appCtrl.appTheme.white,
                                              text:
                                                  socialMediaCtrl.musicResponse,
                                              responseText:
                                                  socialMediaCtrl.musicResponse)
                                        ]),
                                    const VSpace(Sizes.s30),
                                    ButtonCommon(
                                        title: appFonts.endMusicGeneration,
                                        onTap: () => socialMediaCtrl
                                            .endMusicGeneratorDialog()),
                                    const VSpace(Sizes.s30)
                                  ]).paddingSymmetric(
                                vertical: Insets.i30, horizontal: Insets.i20)
                            : const MusicForPostLayout()),
                    if (socialMediaCtrl.isLoader == true) const LoaderLayout()
                  ]))));
    });
  }
}
