

import '../../config.dart';

class NotificationsController extends GetxController {
  List notificationLists = [];

  @override
  void onReady() {
    notificationLists = appArray.notificationsList.map((e) => NotificationModel.fromJson(e)).toList();
    update();
    // TODO: implement onReady
    super.onReady();
  }
}