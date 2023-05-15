import '../../../../config.dart';

class MusicCategoryLayout extends StatelessWidget {
  final String? title, category;
  final GestureTapCallback? onTap;

  const MusicCategoryLayout({Key? key, this.title, this.onTap, this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title!.tr,
          style: AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
      const VSpace(Sizes.s8),
      SizedBox(
              width: double.infinity,
              child: Text(category!,
                  style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt)))
          .paddingAll(Insets.i15)
          .decorated(
              color: appCtrl.appTheme.textField,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.r8)))
          .inkWell(onTap: onTap)
    ]);
  }
}
