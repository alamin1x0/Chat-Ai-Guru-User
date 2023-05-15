import 'dart:developer';
import 'package:probot/screens/auth_screens/mobile_login/layouts/otp_screen.dart';
import '../../config.dart';

class MobileLoginController extends GetxController {
  GlobalKey<FormState> mobileGlobalKey = GlobalKey<FormState>();
  GlobalKey<FormState> otpGlobalKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String? userName,verificationCode;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  onTapOtp() async {
    if (mobileGlobalKey.currentState!.validate()) {
      // Otp Method
      isLoading = true;
      update();
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91 ${mobileController.text.toString()}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) async {
          verificationCode = verificationId;
          var phoneUser = FirebaseAuth.instance.currentUser;

          userName = phoneUser?.phoneNumber;
          isLoading = false;
          update();
          showDialog(
              barrierDismissible: false,
              context: Get.context!,
              builder: (context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return GetBuilder<MobileLoginController>(
                          builder: (mobileCtrl) {
                            return OtpScreen(user: phoneUser,id: verificationCode);
                          });
                    });
              });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
  }

  checkData() async {

    appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
    appCtrl.envConfig = appCtrl.storage.read(session.envConfig);
    appCtrl.update();
  }

  final defaultPinTheme = PinTheme(
      textStyle: AppCss.outfitSemiBold18.textColor(appCtrl.appTheme.txt),
      width: Sizes.s55,
      height: Sizes.s48,
      decoration: BoxDecoration(
          color: appCtrl.appTheme.textField,
          borderRadius: BorderRadius.circular(AppRadius.r5),
          border: Border.all(color: appCtrl.appTheme.trans)));

  //on verify code
  void onVerifyCode() {
    isLoading = true;
    update();

    verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {}

    verificationFailed(FirebaseAuthException authException) {}

    codeSent(String verificationId, int? resendToken) async {
      verificationCode = verificationId;
      var phoneUser = FirebaseAuth.instance.currentUser;
      userName = phoneUser?.phoneNumber;
      isLoading = false;
      update();
    }

    auth.verifyPhoneNumber(
      phoneNumber: "+91${mobileController.text.toString()}",
      timeout: const Duration(seconds: 60),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    isLoading = false;
    update();
  }

  onTapValidateOtp({id, pUser}) async {
    if (otpGlobalKey.currentState!.validate()) {
      try {
        isLoading = true;
        update();
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: id, smsCode: otpController.text.toString());
        await auth.signInWithCredential(credential);
        isLoading = false;
        update();

        await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: auth.currentUser!.uid)
            .limit(1)
            .get()
            .then((value) async {
          log("doc ${value.docs.isEmpty}");
          if (value.docs.isEmpty) {
            FirebaseMessaging.instance.getToken().then((token) async {
              // Update data to server if new user
              await FirebaseFirestore.instance
                  .collection('users')
                  .doc(auth.currentUser!.uid)
                  .set({
                'logintype': "Phone",
                'nickname': pUser?.displayName,
                'email': pUser?.email,
                'phone': pUser?.phoneNumber,
                'id': auth.currentUser!.uid,
                "balance":  appCtrl.firebaseConfigModel!.balance,
                "fcmToken": token,
                "isActive": true
              });
            });
            appCtrl.envConfig["balance"] =  appCtrl.firebaseConfigModel!.balance;
            isLoading = false;
            update();

            appCtrl.storage.write("number", mobileController.text);
            appCtrl.storage.write("id", auth.currentUser!.uid);
            await checkData();
            Get.offAllNamed(routeName.selectLanguageScreen);
          } else {
            bool isResult = value.docs[0].data()["isActive"] ?? true;
            if (isResult) {
              if (value.docs[0].data()["balance"] == null) {
                appCtrl.envConfig["balance"] =  appCtrl.firebaseConfigModel!.balance;
              }
              isLoading = false;
              update();
              appCtrl.storage.write("number", mobileController.text);
              appCtrl.storage.write("id", auth.currentUser!.uid);
              appCtrl.update();
              await checkData();
              Get.offAllNamed(routeName.selectLanguageScreen);
              update();
              await FirebaseMessaging.instance.getToken().then((token) async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(auth.currentUser!.uid)
                    .update({
                  "fcmToken": token,
                  "isActive": true,
                  "balance": appCtrl.envConfig["balance"]
                });
              });
              appCtrl.envConfig["balance"] = value.docs[0].data()["balance"];
            } else {
              showAlertDialog();
            }
          }
        });
      } catch (e) {
        isLoading = false;
        update();
        snackBarMessengers(message: 'Invalid code');
      }
    }
  }

}