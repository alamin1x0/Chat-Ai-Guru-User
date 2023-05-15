import '../../../../config.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      RichText(
          text: TextSpan(
              text: appFonts.alreadyHaveAnAccount.tr,
              style:
                  AppCss.outfitMedium16.textColor(appCtrl.appTheme.lightText),
              children: [
            TextSpan(
                text: appFonts.signIn.tr,
                style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt))
          ])).inkWell(onTap: () => Get.back())
    ]);
  }
}
