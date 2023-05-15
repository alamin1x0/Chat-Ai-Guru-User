import '../../../../config.dart';

class SenderWidthText extends StatelessWidget {
  final String? text;
  final int? index;
  final Widget? time;

  const SenderWidthText({Key? key, this.text, this.index,this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return Container(
        width: Sizes.s250,
        padding: const EdgeInsets.symmetric(
            horizontal: Insets.i10, vertical: Insets.i12),
        decoration: BoxDecoration(
            color: appCtrl.appTheme.boxBg,
            borderRadius: BorderRadius.circular(AppRadius.r6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text!,
              overflow: TextOverflow.clip,
              style: AppCss.outfitMedium14
                  .textColor(appCtrl.appTheme.txt)
                  .textHeight(1.2),
            ),
            const VSpace(Sizes.s10),
            time!
          ],
        ),
      ).inkWell(onTap: () {
        if (chatCtrl.isLongPress) {
          if (!chatCtrl.selectedIndex.contains(index)) {
            chatCtrl.selectedIndex.add(index);
            chatCtrl.selectedData.add(chatCtrl.selectedMessages[index!]);
            chatCtrl.update();
          }else{
            if (chatCtrl.selectedIndex.contains(index)) {
              chatCtrl.selectedIndex.remove(index);
              chatCtrl.selectedData.remove(chatCtrl.selectedMessages[index!]);
              chatCtrl.update();
            }
          }
        } else {
          if (chatCtrl.selectedIndex.contains(index)) {
            chatCtrl.selectedIndex.remove(index);
            chatCtrl.selectedData.remove(chatCtrl.selectedMessages[index!]);
            chatCtrl.update();
          }
        }
      });
    });
  }
}
