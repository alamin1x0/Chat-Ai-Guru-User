import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../config.dart';

// Needed because we can't import `dart:html` into a mobile app,
// while on the flip-side access to `dart:io` throws at runtime (hence the `kIsWeb` check below)

import '../../utils/general_utils.dart';

class SignInController extends GetxController {
  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> signInGlobalKey = GlobalKey<FormState>();

  String? userNameGoogle = "";
  String? userName = "";
  bool obscureText = true;

  //password obscure
  onObscure() {
    obscureText = !obscureText;
    update();
  }

  // SignIn With Google Method
  Future signInWithGoogle() async {
    try {
      appCtrl.isGuestLogin = false;
      appCtrl.storage.write(session.isGuestLogin, false);
      log("message");
      isLoading = true;
      update();
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      User? user = (await auth.signInWithCredential(credential)).user;
      update();
      userNameGoogle = user!.email;

      await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user.uid)
          .limit(1)
          .get()
          .then((result) async {
        if (result.docs.isEmpty) {
          // Update data to server if new user
          FirebaseMessaging.instance.getToken().then((token) async {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .set({
              'logintype': "Google",
              'nickname': user.displayName,
              'email': user.email,
              'phone': user.phoneNumber,
              'id': user.uid,
              "balance": appCtrl.firebaseConfigModel!.balance,
              "fcmToken": token,
              "isActive": true
            });
          });
          appCtrl.envConfig["balance"] =  appCtrl.firebaseConfigModel!.balance;
          isLoading = false;
          appCtrl.storage.write("id", user.uid);
          await checkData();
          Get.offAllNamed(routeName.selectLanguageScreen);
          update();
          appCtrl.storage.write("userName", userNameGoogle);
          appCtrl.storage.write("name", user.displayName);
        } else {
          await FirebaseMessaging.instance.getToken().then((token) async {
            bool isResult  =result.docs[0].data()["isActive"] ?? true;
            if (isResult) {
              log("BANCE :${result.docs[0].data()["balance"] == null}");
              if (result.docs[0].data()["balance"] == null) {
                appCtrl.envConfig["balance"] =  appCtrl.firebaseConfigModel!.balance;
              } else {
                appCtrl.envConfig["balance"] = result.docs[0].data()["balance"];
              }
              update();

              await FirebaseMessaging.instance.getToken().then((token) async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.uid)
                    .update({
                  "fcmToken": token,
                  "isActive": true,
                  "balance": appCtrl.envConfig["balance"]
                });
              });
              isLoading = false;
              appCtrl.storage.write("id", user.uid);
              await checkData();
              Get.offAllNamed(routeName.selectLanguageScreen);
              update();
              appCtrl.storage.write("userName", userNameGoogle);
              appCtrl.storage.write("name", user.displayName);

              appCtrl.envConfig["balance"] = result.docs[0].data()["balance"];
            } else {
              isLoading = false;
              update();
              showAlertDialog();
            }
          });
        }
      });
    } catch (e) {
      isLoading = false;
      update();
    } finally {
      isLoading = false;
      update();
    }
  }

  // Sign In With Email & Password Method
  signInMethod() async {
    appCtrl.isGuestLogin = false;
    appCtrl.storage.write(session.isGuestLogin, false);
    if (signInGlobalKey.currentState!.validate()) {
      // isLoading = true;
      update();
      try {
        var firebaseUser = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.toString(),
                password: passwordController.text.toString());
        var signIn = FirebaseAuth.instance.currentUser;

        FirebaseMessaging.instance.getToken().then((token) async {
          await FirebaseFirestore.instance
              .collection('users')
              .where('id', isEqualTo: firebaseUser.user!.uid)
              .limit(1)
              .get()
              .then((value) async {
            log("doc ${value.docs.isEmpty}");
            if (value.docs.isEmpty) {
              // Update data to server if new user
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(firebaseUser.user!.uid)
                  .set({
                'logintype': "Email",
                'nickname': firebaseUser.user!.displayName,
                'email': firebaseUser.user!.email,
                'phone': firebaseUser.user!.phoneNumber,
                'id': firebaseUser.user!.uid,
                "balance": appCtrl.firebaseConfigModel!.balance,
                "fcmToken": token,
                "isActive": true
              });
              appCtrl.envConfig["balance"] =  appCtrl.firebaseConfigModel!.balance;
              userName = signIn!.email;

              isLoading = false;
              appCtrl.storage.write("userName", userName);
              appCtrl.storage.write("name", signIn.displayName);
              update();
              await checkData();
              Get.offAllNamed(routeName.selectLanguageScreen);
            } else {
              bool isResult  =value.docs[0].data()["isActive"] ?? true;
              if (isResult) {
                log("BANCE :${value.docs[0].data()["balance"] == null}");
                if (value.docs[0].data()["balance"] == null) {
                  appCtrl.envConfig["balance"] =  appCtrl.firebaseConfigModel!.balance;
                } else {
                  appCtrl.envConfig["balance"] =
                      value.docs[0].data()["balance"];
                }
                userName = signIn!.email;

                isLoading = false;
                appCtrl.storage.write("userName", userName);
                appCtrl.storage.write("name", signIn.displayName);
                update();
                await checkData();
                Get.offAllNamed(routeName.selectLanguageScreen);
                await FirebaseMessaging.instance.getToken().then((token) async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(firebaseUser.user!.uid)
                      .update({
                    "fcmToken": token,
                    "isActive": true,
                    "balance": appCtrl.envConfig["balance"]
                  });
                });
                appCtrl.envConfig["balance"] = value.docs[0].data()["balance"];
              } else {
                isLoading = false;
                update();
                showAlertDialog();
              }
            }
          });
        });
        update();
        appCtrl.storage.write("id", firebaseUser.user!.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          isLoading = false;
          update();
          snackBarMessengers(message: appFonts.wrongPassword);
        } else if (e.code == 'user-not-found') {
          isLoading = false;
          update();
          snackBarMessengers(message: appFonts.userNotFound);
        }
      } catch (e) {
        isLoading = false;
        update();
        snackBarMessengers(message: e.toString());
      }
    }
  }

  //sign in with apple
  signInWithApple() async {
    appCtrl.isGuestLogin = false;
    appCtrl.storage.write(session.isGuestLogin, false);
    isLoading = true;
    update();
    try {
      final rawNonce = generateNonces();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      log("CRED : $appleCredential");
      final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: appleCredential.identityToken,
          rawNonce: rawNonce,
          accessToken: appleCredential.authorizationCode);

      log("AUTH : $oauthCredential");
      update();

      await FirebaseAuth.instance
          .signInWithCredential(oauthCredential)
          .then((value) async {
        var signIn = FirebaseAuth.instance.currentUser;
        userName = signIn!.email;

        FirebaseMessaging.instance.getToken().then((token) async {
          await FirebaseFirestore.instance
              .collection('users')
              .where('id', isEqualTo: signIn.uid)
              .limit(1)
              .get()
              .then((value) async {
            log("doc ${value.docs.isEmpty}");
            if (value.docs.isEmpty) {
              // Update data to server if new user
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(signIn.uid)
                  .set({
                'logintype': "Email",
                'nickname': signIn.displayName,
                'email': signIn.email,
                'phone': signIn.phoneNumber,
                'id': signIn.uid,
                "balance":  appCtrl.firebaseConfigModel!.balance,
                "fcmToken": token,
                "isActive": true
              });
              appCtrl.envConfig["balance"] =  appCtrl.firebaseConfigModel!.balance;
              isLoading = false;

              appCtrl.storage.write("userName", userName);
              appCtrl.storage.write("name", signIn.displayName);
              update();
              await checkData();
              Get.offAllNamed(routeName.selectLanguageScreen);
            } else {
              bool isResult  =value.docs[0].data()["isActive"] ?? true;
              if (isResult) {
                log("BANCE :${value.docs[0].data()["balance"] == null}");
                if (value.docs[0].data()["balance"] == null) {
                  appCtrl.envConfig["balance"] =  appCtrl.firebaseConfigModel!.balance;
                } else {
                  appCtrl.envConfig["balance"] =
                      value.docs[0].data()["balance"];
                }
                isLoading = false;

                appCtrl.storage.write("userName", userName);
                appCtrl.storage.write("name", signIn.displayName);
                update();
                await checkData();
                Get.offAllNamed(routeName.selectLanguageScreen);
                await FirebaseMessaging.instance.getToken().then((token) async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(signIn.uid)
                      .update({
                    "fcmToken": token,
                    "isActive": true,
                    "balance": appCtrl.envConfig["balance"]
                  });
                });
                appCtrl.envConfig["balance"] = value.docs[0].data()["balance"];
              } else {
                isLoading = false;
                update();
                showAlertDialog();
              }
            }
          });
          appCtrl.storage.write("id", signIn.uid);
        });
      });

      update();
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      update();

      snackBarMessengers(message: e.code);
    } catch (e) {
      isLoading = false;
      update();

      log("ERROR CATHC ; $e");
    }
  }

  checkData() async {

    appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
    appCtrl.envConfig = appCtrl.storage.read(session.envConfig);
    appCtrl.update();
  }

  @override
  void onClose() {
    signInGlobalKey.currentState;
    // TODO: implement onClose
    super.onClose();
  }
}
