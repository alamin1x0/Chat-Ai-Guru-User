import '../../config.dart';

class SignUpController extends GetxController {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> signUpGlobalKey = GlobalKey<FormState>();


  String? firebaseUser = '';

  bool obscureText = true;
  bool obscureText2 = true;

  //password obscure tap
  onObscure() {
    obscureText = !obscureText;
    update();
  }

  //confirm password obscure tap
  onObscure2() {
    obscureText2 = !obscureText2;
    update();
  }

  // Firebase Register With Email & Password
  signUpMethod() async {
    if (signUpGlobalKey.currentState!.validate()) {
      isLoading = true;
      update();
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString());
        var user = FirebaseAuth.instance.currentUser;
        firebaseUser = user?.email;
        update();
        isLoading = false;
        emailController.text = "";
        passwordController.text = "";
        appCtrl.storage.write("firebaseUser", firebaseUser);

        Get.back();
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {
          isLoading = false;
          update();
          snackBarMessengers(message: appFonts.emailAlreadyUse);
        }
      } catch (e) {
        isLoading = false;
        update();
        snackBarMessengers(message: appFonts.unknownError);
        Get.offAllNamed(routeName.signInScreen);
      }
    }
  }
}
