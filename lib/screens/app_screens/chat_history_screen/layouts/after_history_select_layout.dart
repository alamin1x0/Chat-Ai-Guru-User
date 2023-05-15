import 'dart:developer';

import 'package:probot/screens/app_screens/chat_history_screen/layouts/popup_menu_layout.dart';

import '../../../../config.dart';

class AfterHistorySelectLayout extends StatelessWidget {
  const AfterHistorySelectLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatHistoryController>(builder: (chatCtrl) {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection("chats")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container();
            } else if (!snapshot.hasData) {
              return Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              appCtrl.appTheme.primary)))
                  .height(MediaQuery.of(context).size.height);
            } else {
              log("HAS DATA");
              return PopupMenuLayout(snapshot: snapshot);
            }
          });
    });
  }
}
