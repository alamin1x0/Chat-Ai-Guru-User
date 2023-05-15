import '../../../../config.dart';

class DonHaveAccountLayout extends StatelessWidget {
  const DonHaveAccountLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: RichText(
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: appFonts.dontHaveAnAccount.tr,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.lightText)
                          .textHeight(1.3),
                      children: [
                        TextSpan(
                            text: appFonts.signUp.tr,
                            style: AppCss.outfitMedium16
                                .textColor(appCtrl.appTheme.txt)
                                .textHeight(1.3))
                      ])).inkWell(onTap: () => Get.to(const SignUpScreen())))
        ]);
  }
}
