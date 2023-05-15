import '../config.dart';

class DialogLayout {
  endDialog({title,subTitle,onTap}) {
    Get.generalDialog(
        pageBuilder: (context, anim1, anim2) {
          return AdviserDialog(
              title: title,
              subTitle: subTitle,
              endOnTap: onTap);
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
              position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
                  .animate(anim1),
              child: child
          );
        },
        transitionDuration: const Duration(milliseconds: 300));
  }
}