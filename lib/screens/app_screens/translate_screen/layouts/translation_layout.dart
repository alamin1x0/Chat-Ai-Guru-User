import '../../../../config.dart';


class TranslationLayout extends StatelessWidget {
  final String? from, to;
  final GestureTapCallback? fromOnTap, toOnTap;

  const TranslationLayout(
      {Key? key, this.from, this.to, this.fromOnTap, this.toOnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          ContainerCommonLayout(
              from: from, fromOnTap: fromOnTap, title: appFonts.from),
          Expanded(
              child: Container(height: 1, color: appCtrl.appTheme.primary)
                  .paddingOnly(top: Insets.i20)),
          SizedBox(
                  height: Sizes.s34,
                  width: Sizes.s34,
                  child: SvgPicture.asset(eSvgAssets.translates,
                      fit: BoxFit.scaleDown))
              .decorated(
                  color: appCtrl.appTheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(color: appCtrl.appTheme.white, width: 1))
              .paddingAll(Insets.i1)
              .decorated(
                  color: appCtrl.appTheme.primary, shape: BoxShape.circle)
              .paddingOnly(top: Insets.i20),
          Expanded(
              child: Container(height: 1, color: appCtrl.appTheme.primary)
                  .paddingOnly(top: Insets.i20)),
          ContainerCommonLayout(
              from: to, fromOnTap: toOnTap, title: appFonts.to)
        ]));
  }
}
