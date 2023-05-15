import '../../../../config.dart';

class ChatList extends StatelessWidget {
  final int? index;

  const ChatList({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return appCtrl.isGuestLogin
          ? const GuestChatListLayout()
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chatHistory")
                  .doc(chatCtrl.chatId)
                  .collection("chats")
                  .orderBy("createdDate", descending: false)
                  .snapshots(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  return InkWell(
                      onTap: () => chatCtrl.onListClear(),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              controller: chatCtrl.scrollController,
                              itemCount: snapShot.data!.docs.length,
                              itemBuilder: (context, i) {
                                if (snapShot.data!.docs[i]
                                            .data()["messageType"] ==
                                        ChatMessageType.bot.name ||
                                    snapShot.data!.docs[i]
                                            .data()["messageType"] ==
                                        ChatMessageType.loading.name) {
                                  return Receiver(
                                      chatListModel:
                                          snapShot.data!.docs[i].data(),
                                      index: i);
                                } else {
                                  return Sender(
                                      chatListModel:
                                          snapShot.data!.docs[i].data(),
                                      index: i);
                                }
                              })));
                } else {
                  return Container();
                }
              });
    });
  }
}
