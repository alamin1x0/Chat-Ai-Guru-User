import '../../../config.dart';

class HashtagForPostScreen extends StatelessWidget {
  const HashtagForPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return WillPopScope(
          onWillPop: () => socialMediaCtrl.onClear(),
          child: DirectionalityRtl(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppAppBarCommon(
                      title: appFonts.hashTagsForPost,
                      leadingOnTap: () => socialMediaCtrl.onClear()),
                  body: Stack(children: [
                    SingleChildScrollView(
                        child: Column(children: [
                      const HashtagLayout(),
                      if (socialMediaCtrl.isHashtagGenerated == true)
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InputLayout(
                                  hintText: appFonts.typeHere,
                                  title: appFonts.hashtagsForYou,
                                  isMax: false,
                                  text: socialMediaCtrl.hashtagResponse,
                                  color: appCtrl.appTheme.white,
                                  responseText:
                                      socialMediaCtrl.hashtagResponse),
                              const VSpace(Sizes.s30),
                              ButtonCommon(
                                  title: appFonts.endHashtagBuilder,
                                  onTap: () => socialMediaCtrl
                                      .endHashtagGeneratorDialog()),
                              const VSpace(Sizes.s30),
                              const AdCommonLayout()
                            ])
                    ]).paddingSymmetric(
                            vertical: Insets.i30, horizontal: Insets.i20)),
                    if (socialMediaCtrl.isLoader == true)
                      LoaderScreen(value: socialMediaCtrl.progressValue)
                  ]))));
    });
  }
}
