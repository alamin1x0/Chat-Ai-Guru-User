
import '../../../../config.dart';
import 'after_history_select_layout.dart';

class ChatHistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List? index;
  final GestureTapCallback? onDeleteTap, onMenuTap;

  const ChatHistoryAppBar(
      {Key? key, this.index, this.onDeleteTap, this.onMenuTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatHistoryController>(builder: (chatCtrl) {
      return AppBar(
          elevation: 0,
          toolbarHeight: 70,
          titleSpacing: 0,
          leading: SvgPicture.asset(eSvgAssets.leftArrow,
                  fit: BoxFit.scaleDown,
                  colorFilter: ColorFilter.mode(
                      appCtrl.appTheme.sameWhite, BlendMode.srcIn))
              .inkWell(onTap: () => Get.back()),
          automaticallyImplyLeading: false,
          backgroundColor: appCtrl.appTheme.primary,
          actions: [
            index!.isNotEmpty
                ? SvgPicture.asset(eSvgAssets.delete)
                    .paddingSymmetric(horizontal: Insets.i15)
                    .inkWell(onTap: onDeleteTap)
                : const AfterHistorySelectLayout(),
          ],
          title: Text(
              index!.isNotEmpty
                  ? "${index!.length} Selected"
                  : appFonts.chatHistory.tr,
              style: AppCss.outfitExtraBold22
                  .textColor(appCtrl.appTheme.sameWhite)));
    });
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(70);
}
