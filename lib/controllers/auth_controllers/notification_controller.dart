import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'package:probot/config.dart';

class AllowNotificationController extends GetxController {

  onTapAllow() {
    openAppSettings().then((value)=>  Get.offAllNamed(routeName.loginScreen, arguments: false));
    update();
  }

  @override
  void onReady() async{
    PermissionStatus status = await Permission.notification.request();
    if (status.isGranted) {
      log("GRANTED PERMISSION");
      Get.offAllNamed(routeName.loginScreen, arguments: false);
    }
    else {
      log("NO PERMISSION");
      openAppSettings();
      update();
    }
    // TODO: implement onReady
    super.onReady();
    update();
  }
}