import '../../../../config.dart';

class ContainerCommonLayout extends StatelessWidget {
  final String? from,title;
  final GestureTapCallback? fromOnTap;
  const ContainerCommonLayout({Key? key,this.from,this.fromOnTap,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title!.tr,
          style: AppCss.outfitMedium12
              .textColor(appCtrl.appTheme.lightText)),
      const VSpace(Sizes.s10),
      SizedBox(
          width: Sizes.s120,
          child: Text(from!.tr,
              style: AppCss.outfitMedium16
                  .textColor(appCtrl.appTheme.txt))
              .paddingAll(Insets.i15)
              .decorated(
              color: appCtrl.appTheme.textField,
              borderRadius: const BorderRadius.all(
                  Radius.circular(AppRadius.r8))))
          .inkWell(onTap: fromOnTap)
    ]);
  }
}
