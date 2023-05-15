
import '../../../../config.dart';

class CommonSwitcher extends StatelessWidget {
  final int? index;

  const CommonSwitcher({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
        padding: 4,
        height: Sizes.s20,
        toggleSize: 12,
        inactiveColor: appCtrl.appTheme.txt.withOpacity(.1),
        width: Sizes.s32,
        value: appCtrl.isUserRTLChange ? appCtrl.isUserRTL : appCtrl.isRTL,
        onToggle: (val) {
          appCtrl.storage.write(session.isUserChangeRTL, true);
          appCtrl.isUserRTLChange = true;
          if (appCtrl.isUserRTLChange) {
            appCtrl.isUserRTL = val;
            appCtrl.storage.write(session.isUserRTL, appCtrl.isUserRTL);
            appCtrl.update();
            Get.forceAppUpdate();


          } else {

            appCtrl.isRTL = !appCtrl.isRTL;
            appCtrl.update();
            Get.forceAppUpdate();
          }
        });
  }
}
