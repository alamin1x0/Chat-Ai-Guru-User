import '../../../../config.dart';

class ToneLayout extends StatelessWidget {
  final String? title;
  final int? index,selectedIndex;
  final GestureTapCallback? onTap;
  const ToneLayout({Key? key,this.title,this.index,this.selectedIndex,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            child: Text(title!.toString().tr,
                    style: AppCss.outfitMedium14
                        .textColor(index == selectedIndex ? appCtrl.appTheme.white : appCtrl.appTheme.lightText))
                .paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i10))
        .decorated(
            color: index == selectedIndex ? appCtrl.appTheme.primary : appCtrl.appTheme.textField,
            borderRadius:
                const BorderRadius.all(Radius.circular(AppRadius.r8))).inkWell(onTap: onTap);
  }
}
