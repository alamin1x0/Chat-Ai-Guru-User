import '../../../config.dart';

class RestPasswordScreen extends StatelessWidget {
  final resetPasswordCtrl = Get.put(ResetPasswordController());

  RestPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(builder: (_) {
      return Scaffold(
          appBar: const AppBarCommon(isArrow: false),
          body: Stack(alignment: Alignment.center, children: [
            Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Form(
                      key: resetPasswordCtrl.resetPasswordGlobalKey,
                      child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(appFonts.resetPassword.tr,
                                        style: AppCss.outfitSemiBold22
                                            .textColor(appCtrl.appTheme.txt)),
                                    const VSpace(Sizes.s10),
                                    Text(appFonts.enterYourMailOr.tr,
                                        style: AppCss.outfitMedium16.textColor(
                                            appCtrl.appTheme.lightText)),
                                    const DottedLines().paddingOnly(
                                        top: Insets.i20, bottom: Insets.i15),
                                    Text(appFonts.email.tr,
                                        style: AppCss.outfitMedium16
                                            .textColor(appCtrl.appTheme.txt)),
                                    const VSpace(Sizes.s10),
                                    TextFieldCommon(
                                        validator: (email) =>
                                            Validation().emailValidation(email),
                                        controller:
                                            resetPasswordCtrl.emailController,
                                        hintText: appFonts.enterEmail.tr),
                                    const VSpace(Sizes.s40),
                                    ButtonCommon(
                                        title: appFonts.resetPassword,
                                        onTap: () =>
                                            resetPasswordCtrl.onResetPassword())
                                  ]).paddingSymmetric(
                                  horizontal: Insets.i20, vertical: Insets.i25))
                          .authBoxExtension()),
                  Text(appFonts.simplyUseThis.tr,
                      textAlign: TextAlign.center,
                      style: AppCss.outfitMedium16
                          .textColor(appCtrl.appTheme.lightText)
                          .textHeight(1.3))
                ])
                .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i15),
            if (resetPasswordCtrl.isLoading == true)
              const Center(child: CircularProgressIndicator())
          ]));
    });
  }
}
