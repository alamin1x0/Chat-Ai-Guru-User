import 'package:intl/intl.dart';

import '../../../../config.dart';
import '../../../../widgets/common_volume.dart';

class GuestSender extends StatelessWidget {
  final ChatMessage? chatListModel;
  final int? dateWiseIndex, index;

  const GuestSender(
      {Key? key, this.chatListModel, this.index, this.dateWiseIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return Align(
              alignment: Alignment.centerRight,
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                chatListModel!.text!.length > 40
                    ? SenderWidthText(
                        text: chatListModel!.text!,
                        index: index,
                        time: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('hh:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(
                                            chatListModel!.time!.toString()))),
                                style: AppCss.outfitMedium12
                                    .textColor(appCtrl.appTheme.sameWhite),
                              ),
                              CommonVolume(message: chatListModel!.text!)
                            ])).inkWell(onTap: () => chatCtrl.onTapUnselect())
                    : CommonContent(
                        text: chatListModel!.text!,
                        index: index,
                        time: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  DateFormat('hh:mm a').format(DateTime
                                      .fromMillisecondsSinceEpoch(int.parse(
                                          chatListModel!.time!.toString()))),
                                  style: AppCss.outfitMedium12
                                      .textColor(appCtrl.appTheme.sameWhite)),
                              const HSpace(Sizes.s15),
                              CommonVolume(message: chatListModel!.text!)
                            ])).inkWell(onTap: () => chatCtrl.onTapUnselect()),
                const VSpace(Sizes.s3)
              ]).marginSymmetric(horizontal: Insets.i20, vertical: Insets.i5))
          .backgroundColor(chatCtrl.isLongPress == true
              ? chatCtrl.selectedIndex.contains(index)
                  ? appCtrl.appTheme.primaryLight
                  : appCtrl.appTheme.trans
              : appCtrl.appTheme.trans)
          .onLongPressTap(onLongPress: () {
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
