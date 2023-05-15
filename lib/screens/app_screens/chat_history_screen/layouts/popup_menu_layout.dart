import '../../../../config.dart';

class PopupMenuLayout extends StatelessWidget {
  final AsyncSnapshot<dynamic>? snapshot;

  const PopupMenuLayout({Key? key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatHistoryController>(builder: (chatCtrl) {
      return PopupMenuButton(
          padding: EdgeInsets.zero,
          icon: SvgPicture.asset(eSvgAssets.more,
              height: Sizes.s20, fit: BoxFit.fill),
          onSelected: (result) async {
            if (result == 0) {
              chatCtrl.isLongPress = true;
              snapshot!.data!.docs.asMap().entries.forEach((element) {
                if (!chatCtrl.selectedIndex.contains(element.value.id)) {
                  chatCtrl.selectedIndex.add(element.value.id);
                  chatCtrl.update();
                }
              });
            } else {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("chats")
                  .get()
                  .then((value) {
                snapshot!.data!.docs.asMap().entries.forEach((element) {
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
                  });
                });
              });
              chatCtrl.selectedIndex = [];
              chatCtrl.update();
              chatCtrl.clearChatSuccessDialog();
            }
          },
          iconSize: Sizes.s20,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.r8)),
          itemBuilder: (ctx) => [
                chatCtrl.buildPopupMenuItem(appFonts.selectAll.tr, 0),
                chatCtrl.buildPopupMenuItem(appFonts.clearAll.tr, 1)
              ]);
    });
  }
}
