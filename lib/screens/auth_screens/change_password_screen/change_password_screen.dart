import '../../../config.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarCommon(isArrow: false),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(appFonts.changePassword,
                          style: AppCss.outfitSemiBold22
                              .textColor(appCtrl.appTheme.txt)),
                      const VSpace(Sizes.s10),
                      Text(appFonts.dontUseOneOf,
                          style: AppCss.outfitMedium16
                              .textColor(appCtrl.appTheme.lightText)),
                      const DottedLines().paddingOnly(
                          top: Insets.i20, bottom: Insets.i15),
                      Text(appFonts.newPassword,
                          style: AppCss.outfitMedium16
                              .textColor(appCtrl.appTheme.txt)),
                      const VSpace(Sizes.s10),
                      TextFieldCommon(hintText: appFonts.enterPassword),
                      const VSpace(Sizes.s15),
                      Text(appFonts.confirmPassword,
                          style: AppCss.outfitMedium16
                              .textColor(appCtrl.appTheme.txt)),
                      const VSpace(Sizes.s10),
                      TextFieldCommon(hintText: appFonts.reEnterPassword),
                      const VSpace(Sizes.s40),
                      ButtonCommon(title: appFonts.updatePassword)
                    ]).paddingSymmetric(
                    horizontal: Insets.i20, vertical: Insets.i25))
                .authBoxExtension(),
            Text(appFonts.simplyUseThis,
                textAlign: TextAlign.center,
                style: AppCss.outfitMedium16
                    .textColor(appCtrl.appTheme.lightText)
                    .textHeight(1.3))
          ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i15)
    );
  }
}
