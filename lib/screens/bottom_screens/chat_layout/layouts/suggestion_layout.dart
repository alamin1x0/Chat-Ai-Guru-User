import '../../../../config.dart';

class SuggestionLayout extends StatelessWidget {
  final dynamic data;
  final int? index, selectIndex;
  final GestureTapCallback? onTap;

  const SuggestionLayout({Key? key, this.data, this.selectIndex, this.index,this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            child: Text(data["title"].toString().tr,
                    style: AppCss.outfitSemiBold14
                        .textColor(index == selectIndex ? appCtrl.appTheme.sameWhite : appCtrl.appTheme.primary))
                .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i10)
                .decorated(
                    color: index == selectIndex ? appCtrl.appTheme.primary : appCtrl.appTheme.primaryLight,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppRadius.r6)))).paddingOnly(right: Insets.i8)
        .inkWell(onTap: onTap);
  }
}
