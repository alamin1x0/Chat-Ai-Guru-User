import '../../../../config.dart';

class SocialMediaListLayout extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTap;
  final int? index, totalLength;

  const SocialMediaListLayout(
      {Key? key, this.data, this.onTap, this.index, this.totalLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          SizedBox(
              height: Sizes.s52,
              width: Sizes.s52,
              child: SvgPicture.asset(data["image"],
                      colorFilter: ColorFilter.mode(
                          appCtrl.appTheme.sameWhite, BlendMode.srcIn))
                  .paddingAll(Insets.i15)
                  .decorated(
                      color: appCtrl.appTheme.primary,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppRadius.r8)))),
          const HSpace(Sizes.s12),
          Text(data["title"]!.toString().tr,
              style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt))
        ]),
        SvgPicture.asset(
                appCtrl.isRTL || appCtrl.languageVal == "ar"
                    ? eSvgAssets.leftArrow
                    : eSvgAssets.rightArrow1,
                height: 15,
                colorFilter:
                    ColorFilter.mode(appCtrl.appTheme.txt, BlendMode.srcIn))
            .paddingSymmetric(horizontal: Insets.i10)
      ]),
      if (index != totalLength) const VSpace(Sizes.s15),
      if (index != totalLength)
        const Divider(height: 1, thickness: 1).paddingOnly(bottom: Insets.i15)
    ]).inkWell(onTap: onTap);
  }
}
