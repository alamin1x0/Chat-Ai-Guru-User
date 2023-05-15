import '../config.dart';

class SelectGenderLayout extends StatelessWidget {
  final int? index,selectedIndex;
  final dynamic data;
  final GestureTapCallback? onTap;
  const SelectGenderLayout({Key? key,this.onTap,this.selectedIndex,this.data,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Sizes.s65,
            width: Sizes.s65,
            child: SvgPicture.asset(data["image"],
                colorFilter: ColorFilter.mode(
                   index == selectedIndex ? appCtrl.appTheme.sameWhite : appCtrl.appTheme.primary, BlendMode.srcIn)),
          ),
          const VSpace(Sizes.s25),
          Text(data["title"],
              style: AppCss.outfitSemiBold16
                  .textColor(index == selectedIndex ? appCtrl.appTheme.sameWhite : appCtrl.appTheme.txt))
        ]).paddingSymmetric(
        vertical: Insets.i17, horizontal: Insets.i30).inkWell(onTap: onTap)
        .decorated(
        color: index == selectedIndex ? appCtrl.appTheme.primary : appCtrl.appTheme.textField,
        borderRadius:
        const BorderRadius.all(Radius.circular(AppRadius.r6)))
        .paddingAll(Insets.i8)
        .decorated(
        color: index == selectedIndex ? appCtrl.appTheme.primaryLight : appCtrl.appTheme.textField,
        borderRadius:
        const BorderRadius.all(Radius.circular(AppRadius.r6)));
  }
}
