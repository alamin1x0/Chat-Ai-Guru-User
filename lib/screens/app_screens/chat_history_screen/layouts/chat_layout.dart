import 'package:intl/intl.dart';

import '../../../../config.dart';
import 'chat_history_image_common.dart';

class ChatHistoryLayout extends StatelessWidget {
  final dynamic data;
  final GestureLongPressCallback? onLongPressTap;
  final GestureTapCallback? onTap;
  final bool? isLongPress;
  final int? index;
  final String? id;

  const ChatHistoryLayout(
      {Key? key,
      this.data,
      this.onLongPressTap,
      this.isLongPress = false,
      this.onTap,
      this.index,
      this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatHistoryController>(builder: (chatHistoryCtrl) {
      return SizedBox(
              child: Row(children: [
        Stack(alignment: Alignment.bottomRight, children: [
          ChatHistoryImageCommon(data: data),
          if (chatHistoryCtrl.selectedIndex.contains(index))
            SvgPicture.asset(eSvgAssets.tick)
        ]),
        const HSpace(Sizes.s10),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(data["message"].toString().tr,
              style: AppCss.outfitMedium14
                  .textColor(appCtrl.appTheme.txt)
                  .textHeight(1.2)),
          const VSpace(Sizes.s5),
          IntrinsicHeight(
              child: Row(children: [
            Text(
                DateFormat('hh:mm a').format(
                    DateTime.fromMillisecondsSinceEpoch(
                        int.parse(data["createdDate"].toString()))),
                style:
                    AppCss.outfitMedium12.textColor(appCtrl.appTheme.lightText))
          ]))
        ]))
      ])
                  .padding(
                      horizontal: Insets.i15,
                      top: Insets.i15,
                      bottom: Insets.i12)
                  .inkWell(onTap: onTap))
          .decorated(
              color: chatHistoryCtrl.selectedIndex.contains(id)
                  ? appCtrl.appTheme.primaryLight
                  : appCtrl.appTheme.boxBg,
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.r10)))
          .paddingOnly(bottom: Insets.i15)
          .onLongPressTap(onLongPress: onLongPressTap);
    });
  }
}
