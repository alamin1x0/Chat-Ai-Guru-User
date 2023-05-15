import 'dart:developer';
import '../../../../config.dart';

class Receiver extends StatelessWidget {
  final dynamic chatListModel;
  final int? index;

  const Receiver({
    Key? key,
    this.chatListModel,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
log("MESSAGE ${chatListModel["message"]}");
      return Align(
          alignment: Alignment.centerLeft,
          child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChatCommonWidget()
                    .userImage(chatCtrl.argImage),
                const HSpace(Sizes.s6),
                chatListModel["messageType"] == ChatMessageType.loading.name
                    ? const ChatLoaderCommon()
                    : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          /*chatListModel["createdDate"].toString()*/
                          /*chatListModel["message"]*/
                          chatListModel["message"].length > 40
                              ? ReceiverWidthText(
                            text: chatListModel["message"],width: Sizes.s250,time: chatListModel["createdDate"])
                              : ReceiverWidthText(
                              text: chatListModel["message"],width: Sizes.s200,time: chatListModel["createdDate"]),
                          const HSpace(Sizes.s5)

                        ]
                      ),
                      const VSpace(Sizes.s3)

                    ]).inkWell(onTap: ()=> chatCtrl.onTapUnselect())
              ])
              .marginSymmetric(horizontal: Insets.i20, vertical: Insets.i5)).backgroundColor(chatCtrl.isLongPress == true
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
      });
    });
  }
}
