import 'dart:developer';
import '../../../../config.dart';

class GuestReceiver extends StatelessWidget {
  final ChatMessage? chatListModel;
  final int? index;

  const GuestReceiver({
    Key? key,
    this.chatListModel,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return Align(
              alignment: Alignment.centerLeft,
              child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    ChatCommonWidget()
                        .userImage(appCtrl.selectedCharacter["image"]),
                    const HSpace(Sizes.s6),
                    chatListModel!.chatMessageType == ChatMessageType.loading
                        ? const ChatLoaderCommon()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      chatListModel!.text!.length > 40
                                          ? ReceiverWidthText(
                                              width: Sizes.s250,
                                              text: chatListModel!.text,
                                              time: chatListModel!.time)
                                          : ReceiverWidthText(
                                              width: Sizes.s200,
                                              text: chatListModel!.text,
                                              time: chatListModel!.time),
                                      const HSpace(Sizes.s5)
                                    ]),
                                const VSpace(Sizes.s3),
                              ]).inkWell(
                            onTap: () => chatCtrl.onTapUnselect(),
                          )
                  ])
                  .marginSymmetric(horizontal: Insets.i20, vertical: Insets.i5))
          .backgroundColor(chatCtrl.isLongPress == true
              ? chatCtrl.selectedIndex.contains(index)
                  ? appCtrl.appTheme.primaryLight
                  : appCtrl.appTheme.trans
              : appCtrl.appTheme.trans)
          .onLongPressTap(onLongPress: () {
        log("chatCtrl.shareMessages[index!] : ${chatCtrl.selectedMessages[index!]}");
        chatCtrl.isLongPress = true;
        if (!chatCtrl.selectedIndex.contains(index)) {
          chatCtrl.selectedIndex.add(index);
          chatCtrl.selectedData.add(chatCtrl.selectedMessages[index!]);
          chatCtrl.update();
        }
        log("chatCtrl.isLongPress : ${chatCtrl.isLongPress}");
        chatCtrl.update();
      });
    });
  }
}
