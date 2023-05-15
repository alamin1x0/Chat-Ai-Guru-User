import '../../../config.dart';

class SocialMediaScreen extends StatelessWidget {
  final socialMediaCtrl = Get.put(SocialMediaController());

  SocialMediaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return DirectionalityRtl(
          child: Scaffold(
              appBar: AppAppBarCommon(
                  title: appFonts.socialMedia, leadingOnTap: () => Get.back()),
              body: Stack(alignment: Alignment.bottomCenter, children: [
                Column(children: [
                  Text(appFonts.chooseOneOfThese.tr,
                      style: AppCss.outfitSemiBold16
                          .textColor(appCtrl.appTheme.primary)),
                  const VSpace(Sizes.s15),
                  SizedBox(
                          child: Column(
                              children: socialMediaCtrl.socialMediaLists
                                  .asMap()
                                  .entries
                                  .map((e) => SocialMediaListLayout(
                                      data: e.value,
                                      index: e.key,
                                      totalLength: socialMediaCtrl
                                              .socialMediaLists.length -
                                          1,
                                      onTap: () =>
                                          socialMediaCtrl.onGoPage(e.value)))
                                  .toList()))
                      .paddingSymmetric(
                          vertical: Insets.i20, horizontal: Insets.i15)
                      .authBoxExtension()
                ]).paddingSymmetric(
                    vertical: Insets.i30, horizontal: Insets.i20),
                AdCommonLayout(
                    bannerAd: socialMediaCtrl.bannerAd,
                    bannerAdIsLoaded: socialMediaCtrl.bannerAdIsLoaded,
                    currentAd: socialMediaCtrl.currentAd)
              ])));
    });
  }
}
