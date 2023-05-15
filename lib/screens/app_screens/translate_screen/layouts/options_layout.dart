import '../../../../config.dart';

class OptionsLayout extends StatelessWidget {
  final String? image;
  final GestureTapCallback? onTap;

  const OptionsLayout({Key? key, this.image, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      SizedBox(
          height: Sizes.s40,
          width: Sizes.s40,
          child: SvgPicture.asset(image!,
                  colorFilter: ColorFilter.mode(
                      appCtrl.appTheme.primary, BlendMode.srcIn),
                  fit: BoxFit.scaleDown)
              .decorated(
                  color: appCtrl.appTheme.white,
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: appCtrl.appTheme.primary, width: 1))),
      SizedBox(
          width: Sizes.s40,
          height: Sizes.s58,
          child: Column(children: [
            Container(
                height: Sizes.s15, width: 1, color: appCtrl.appTheme.primary),
            const SizedBox(height: 6, width: 6).decorated(
                color: appCtrl.appTheme.sameWhite,
                shape: BoxShape.circle,
                border: Border.all(color: appCtrl.appTheme.primary, width: 1))
          ])).inkWell(onTap: onTap)
    ]);
  }
}
