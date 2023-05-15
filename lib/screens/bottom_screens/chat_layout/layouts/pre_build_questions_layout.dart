import '../../../../config.dart';

class PreBuildQuestionsLayout extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTap;
  const PreBuildQuestionsLayout({Key? key,this.data,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Text(data,
            style: AppCss.outfitMedium14
                .textColor(appCtrl.appTheme.txt))
            .paddingSymmetric(
            horizontal: Insets.i15, vertical: Insets.i12)
            .decorated(
            color: appCtrl.appTheme.textField,
            borderRadius: const BorderRadius.all(
                Radius.circular(AppRadius.r8)))).paddingOnly(bottom: Insets.i12).inkWell(onTap: onTap);
  }
}
