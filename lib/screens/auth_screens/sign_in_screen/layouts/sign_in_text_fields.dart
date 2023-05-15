import 'dart:io';
import '../../../../config.dart';

class SignInTextField extends StatelessWidget {
  const SignInTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(builder: (signInCtrl) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(appFonts.welcomeBack.tr,
            style: AppCss.outfitSemiBold22.textColor(appCtrl.appTheme.txt)),
        const VSpace(Sizes.s10),
        Text(appFonts.fillTheBelow.tr,
            style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.lightText)),
        const DottedLines().paddingOnly(top: Insets.i20, bottom: Insets.i15),
        textCommon.outfitMediumTxt16(text: appFonts.email.tr),
        const VSpace(Sizes.s10),
        TextFieldCommon(
            validator: (email) => Validation().emailValidation(email),
            controller: signInCtrl.emailController,
            hintText: appFonts.enterEmail.tr),
        const VSpace(Sizes.s15),
        textCommon.outfitMediumTxt16(text: appFonts.password.tr),
        const VSpace(Sizes.s10),
        TextFieldCommon(
            suffixIcon: SvgPicture.asset(
                    signInCtrl.obscureText
                        ? eSvgAssets.eyeSlash
                        : eSvgAssets.eye,
                    fit: BoxFit.scaleDown)
                .inkWell(onTap: () => signInCtrl.onObscure()),
            obscureText: signInCtrl.obscureText,
            validator: (password) => Validation().passValidation(password),
            controller: signInCtrl.passwordController,
            hintText: appFonts.enterPassword.tr),
        const VSpace(Sizes.s10),
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Text(appFonts.resetPassword.tr,
                  style:
                      AppCss.outfitMedium14.textColor(appCtrl.appTheme.primary))
              .inkWell(onTap: () => Get.toNamed(routeName.restPasswordScreen))
        ]),
        const VSpace(Sizes.s40),
        ButtonCommon(
            title: appFonts.signIn, onTap: () => signInCtrl.signInMethod()),
        const VSpace(Sizes.s15),
        const DonHaveAccountLayout(),
        const OrLayout().alignment(Alignment.center),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          CommonSocialLogin(
              image: eSvgAssets.google,
              name: appFonts.google,
              onTap: () => signInCtrl.signInWithGoogle()),
          CommonSocialLogin(
              image: eSvgAssets.mobile,
              name: appFonts.phone,
              onTap: () => Get.toNamed(routeName.mobileLogin)),
          if (Platform.isIOS)
            CommonSocialLogin(
                image: eSvgAssets.apple,
                name: appFonts.apple,
                onTap: () => signInCtrl.signInWithApple())
        ])
      ])
          .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i25)
          .authBoxExtension();
    });
  }
}
