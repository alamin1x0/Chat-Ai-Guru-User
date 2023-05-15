import '../../../../config.dart';


class GuestChatListLayout extends StatelessWidget {
  const GuestChatListLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(
      builder: (chatCtrl) {
        return InkWell(
            onTap: () => chatCtrl.onListClear(),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    controller: chatCtrl.scrollController,
                    itemCount: chatCtrl.itemCount.value,
                    itemBuilder: (context, i) {
                      if (chatCtrl.messages.value[i].chatMessageType ==
                          ChatMessageType.bot ||
                          chatCtrl.messages.value[i].chatMessageType ==
                              ChatMessageType.loading) {
                        return GuestReceiver(
                            chatListModel: chatCtrl.messages.value[i],
                            index: i);
                      } else {
                        return GuestSender(
                            chatListModel: chatCtrl.messages.value[i],
                            index: i);
                      }
                    })));
      }
    );
  }
}
