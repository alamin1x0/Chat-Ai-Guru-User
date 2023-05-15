import '../../../../config.dart';

class ShareLayout extends StatelessWidget {
  const ShareLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: appCtrl.appTheme.trans,
        child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(appFonts.shareToFriend.tr,
                          style: AppCss.outfitblack20
                              .textColor(appCtrl.appTheme.txt)
                              .textDecoration(TextDecoration.none))
                      .paddingSymmetric(horizontal: Insets.i20),
                  InkWell(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(
                        eSvgAssets.cancel,
                        height: Sizes.s24,
                      ))
                ],
              ).paddingAll(Insets.i20),
              DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1,
                  dashLength: 3,
                  dashColor: appCtrl.appTheme.txt.withOpacity(.2)),
              const VSpace(Sizes.s25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChatCommonWidget()
                      .socialLayout(eSvgAssets.wa, appFonts.whatsapp.tr),
                  ChatCommonWidget()
                      .socialLayout(eSvgAssets.insta, appFonts.insta.tr),
                  ChatCommonWidget()
                      .socialLayout(eSvgAssets.tele, appFonts.tele.tr),
                ],
              ).marginSymmetric(horizontal: Insets.i38),
              const VSpace(Sizes.s25),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                ChatCommonWidget().socialLayout(eSvgAssets.fb, appFonts.fb.tr),
                ChatCommonWidget()
                    .socialLayout(eSvgAssets.slack, appFonts.slack.tr),
                const SizedBox(height: Sizes.s60, width: Sizes.s60)
              ]).marginSymmetric(horizontal: Insets.i38),
              const VSpace(Sizes.s25)
            ])
            .decorated(
                color: appCtrl.appTheme.white,
                borderRadius: BorderRadius.circular(AppRadius.r10))
            .marginSymmetric(horizontal: Insets.i20));
  }
}
