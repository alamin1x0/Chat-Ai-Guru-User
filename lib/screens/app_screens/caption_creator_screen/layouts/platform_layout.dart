import '../../../../config.dart';

class PlatformLayout extends StatelessWidget {
  final dynamic data;
  final int? index, selectedIndex;
  final GestureTapCallback? onTap;

  const PlatformLayout(
      {Key? key, this.data, this.onTap, this.index, this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: Sizes.s110,
            child: Row(children: [
              index == selectedIndex
                  ? Icon(Icons.check_circle,
                      color: appCtrl.appTheme.sameWhite, size: Sizes.s20)
                  : SvgPicture.asset(data["image"]!,
                      height: Sizes.s20, fit: BoxFit.scaleDown),
              const HSpace(Sizes.s8),
              Text(data["title"]!.toString().tr,
                  style: AppCss.outfitSemiBold14.textColor(
                      index == selectedIndex
                          ? appCtrl.appTheme.sameWhite
                          : appCtrl.appTheme.txt))
            ]))
        .paddingSymmetric(vertical: Insets.i8, horizontal: Insets.i8)
        .decorated(
            color: index == selectedIndex
                ? appCtrl.appTheme.primary
                : appCtrl.appTheme.textField,
            borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r6)))
        .inkWell(onTap: onTap);
  }
}
