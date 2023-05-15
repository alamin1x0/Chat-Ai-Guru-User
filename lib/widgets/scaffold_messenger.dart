// Scaffold Messenger Common
import '../config.dart';

snackBarMessengers({message, color}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(message.toString().tr,
          style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.sameWhite)),
      backgroundColor: color ?? appCtrl.appTheme.error));
}

showAlertDialog() {
  showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return AlertDialog(

          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(AppRadius.r14))),
          backgroundColor: appCtrl.appTheme.white,
          title: Text(appFonts.alert.tr),

          actions: [
            ButtonCommon(
                title: appFonts.cancel, width: Sizes.s100, onTap: () => Get.back())
          ],

          content:
              const Text("Your account status is In-Active. Please contact to admin"),
        );
      });
}
