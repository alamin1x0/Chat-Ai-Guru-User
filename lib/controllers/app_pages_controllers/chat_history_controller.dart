import 'package:probot/config.dart';

class ChatHistoryController extends GetxController {

  List chatHistoryLists = [];
  List historyTagLists = [];
  bool isLongPress = false;
  List selectedIndex = [];
  List selectedData = [];
  int selectIndex = 0;

  onHistoryTagChange (index) {
    selectIndex = index;
    update();
  }

  @override
  void onReady() {
    chatHistoryLists = appArray.chatHistoryList;
    historyTagLists = appArray.historyTagList;
    update();
    // TODO: implement onReady
    super.onReady();
  }


  //pop up menu item
  PopupMenuItem buildPopupMenuItem(
      String title,int position) {
    return PopupMenuItem(
        value: position,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt)),
          const VSpace(Sizes.s15),
          if (position != 1)
            Divider(height: 0, color: appCtrl.appTheme.greyLight, thickness: 1)
        ]));
  }


  //clear chat success
  clearChatSuccessDialog() {
    Get.generalDialog(
      pageBuilder: (context, anim1, anim2) {
        return const Align(
          alignment: Alignment.center,
          child: ClearChatSuccess(),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  onTapChat (id,data) {

    if (isLongPress) {
      if (!selectedIndex
          .contains(id)) {
       selectedIndex
            .add(id);
        update();
      } else {
        if (selectedIndex
            .contains(id)) {
        selectedIndex
              .remove(id);
          update();
        }
      }
    } else {
      Get.toNamed(
          routeName.chatLayout,
          arguments:
         data);
      final chatCtrl = Get.isRegistered<ChatLayoutController>() ? Get.find<ChatLayoutController>() : Get.put(ChatLayoutController());
      chatCtrl.getChatId();
    }

    if (selectedIndex.isEmpty) {
   isLongPress =
      false;

      update();
      Get.forceAppUpdate();
    }
  }

  onLogPressChat(id) {
    isLongPress =
    true;
    if (!selectedIndex
        .contains(id)) {
      selectedIndex
          .add(id);
      update();
    }
    update();
  }

  onTapDeleteHistory() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("chats")
        .orderBy("createdDate", descending: true)
        .get()
        .then((value) {
      value.docs.asMap().entries.forEach((element) {
        if (selectedIndex
            .contains(element.value.id)) {
          FirebaseFirestore.instance
              .collection("chatHistory")
              .doc(element.value.id)
              .delete()
              .then((value) {
            FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("chats")
                .doc(element.value.id)
                .delete();
            selectedIndex.removeWhere(
                    (elements) => elements == element.value.id);
            update();
          });
        }
      });
    });
    update();
  }

}