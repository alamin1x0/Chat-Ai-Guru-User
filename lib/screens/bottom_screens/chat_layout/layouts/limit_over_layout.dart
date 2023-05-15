import '../../../../config.dart';

class LimitOverLayout extends StatelessWidget {
  final GestureTapCallback? onTap;
  const LimitOverLayout({Key? key,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
          child: Column(children: [
            SizedBox(
                    child: SizedBox(
                        width: Sizes.s300,
                        child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                                text: appFonts.youHitTheMessage.tr,
                                style: AppCss.outfitMedium14
                                    .textColor(appCtrl.appTheme.error)
                                    .textHeight(1.3),
                                children: [
                                  TextSpan(
                                      text: appFonts.clickBelow.tr,
                                      style: AppCss.outfitSemiBold14
                                          .textColor(appCtrl.appTheme.error)
                                          .textHeight(1.3)),
                                  TextSpan(
                                      text: appFonts.toGet.tr,
                                      style: AppCss.outfitMedium14
                                          .textColor(appCtrl.appTheme.error)
                                          .textHeight(1.3)),
                                  TextSpan(
                                      text: appFonts.reward.tr,
                                      style: AppCss.outfitSemiBold14
                                          .textColor(appCtrl.appTheme.error)
                                          .textHeight(1.3)),
                                  TextSpan(
                                      text: appFonts.orSelect.tr,
                                      style: AppCss.outfitMedium14
                                          .textColor(appCtrl.appTheme.error)
                                          .textHeight(1.3))
                                ]))))
                .padding(
                    horizontal: Insets.i15, top: Insets.i12, bottom: Insets.i25)
                .decorated(
                    color: appCtrl.appTheme.error.withOpacity(0.15),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppRadius.r8)))
          ])),
      SizedBox(
              width: MediaQuery.of(context).size.width * 0.33,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset(eSvgAssets.play),
                Text(appFonts.watchVideo.tr,
                    style: AppCss.outfitSemiBold12
                        .textColor(appCtrl.appTheme.sameWhite))
              ]).paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i8)).inkWell(onTap: onTap)
          .decorated(
              color: appCtrl.appTheme.error,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.r4)))
    ]).paddingOnly(bottom: Insets.i20);
  }
}
