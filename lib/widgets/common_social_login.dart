import '../config.dart';

class CommonSocialLogin extends StatelessWidget {
  final String? name, image;
  final GestureTapCallback? onTap;

  const CommonSocialLogin({Key? key, this.onTap, this.name, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SvgPicture.asset(
        image!,
        height: Sizes.s30,
        width: Sizes.s30,
      ),
      const VSpace(Sizes.s8),
      Text(name.toString().tr,
          style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt))
    ])
        .paddingOnly(
            left: name.toString().tr == appFonts.google.tr ? Insets.i18 : Insets.i22,
            right: name == appFonts.google ? Insets.i18 : Insets.i22,
            top: Insets.i18,
            bottom: Insets.i16)
        .decorated(
            color: appCtrl.appTheme.textField,
            borderRadius: BorderRadius.circular(AppRadius.r8))
        .inkWell(onTap: onTap);
  }
}
