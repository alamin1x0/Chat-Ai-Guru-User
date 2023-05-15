import 'dart:developer';
import 'package:probot/config.dart';

class SubscriptionFirebaseController extends GetxController {

  // add or update firebase data
  addUpdateFirebaseData() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "balance": appCtrl.envConfig["balance"],
    }).then((value) async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((userVal) {
        if (userVal.exists) {
          appCtrl.envConfig["balance"] = userVal.data()!["balance"];
          appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
          appCtrl.envConfig = appCtrl.storage.read(session.envConfig);
          update();
        }
      });
    });
  }

  removeBalance() {
    int balance = appCtrl.envConfig["balance"];
    if (balance == 0) {
      appCtrl.balanceTopUpDialog();
    } else {
      balance = balance - 1;
      appCtrl.envConfig["balance"] = balance;
      log("BALANCE : ${appCtrl.envConfig["balance"]}");

      update();
      if (!appCtrl.isGuestLogin) {
        addUpdateFirebaseData();
      } else {
        log("BALANCE : ${appCtrl.envConfig["balance"]}");

        appCtrl.storage.write(session.envConfig, appCtrl.envConfig);
        appCtrl.update();
      }
    }
  }
}
