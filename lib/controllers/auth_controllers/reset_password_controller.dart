
import '../../config.dart';

class ResetPasswordController extends GetxController {
  GlobalKey<FormState> resetPasswordGlobalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  // Reset Password Method
  onResetPassword() {
    if (resetPasswordGlobalKey.currentState!.validate()) {
      isLoading = true;
      try {
        FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.toString());
        isLoading = false;
        snackBarMessengers(message: appFonts.emailSend,color: appCtrl.appTheme.icon);
        Get.offAllNamed(routeName.signInScreen);
      } catch (e) {
        isLoading = false;
        snackBarMessengers(message: appFonts.unknownError);
      }
    }
  }
}
