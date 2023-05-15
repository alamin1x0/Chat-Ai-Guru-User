import '../../../../config.dart';

class BottomLayout extends StatelessWidget {
  const BottomLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 1,
          dashLength: 3,
          dashColor: appCtrl.appTheme.txt.withOpacity(.2))
          .marginSymmetric(vertical: Insets.i20),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(appFonts.darkTheme.tr,
            style:
            AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt)),
        FlutterSwitch(
            value: appCtrl.isUserThemeChange ? appCtrl.isUserTheme : appCtrl.isTheme,
            padding: 4,
            height: Sizes.s20,
            toggleSize: 12,
            inactiveColor: appCtrl.appTheme.txt.withOpacity(.1),
            width: Sizes.s32,
            onToggle: (val) async {
              appCtrl.storage.write(session.isUserThemeChange, true);
              appCtrl.isUserThemeChange = true;
              if(appCtrl.isUserThemeChange ){
                appCtrl.isUserTheme = val;

                appCtrl.update();
                ThemeService().switchTheme(appCtrl.isUserTheme);
                Get.forceAppUpdate();
              }else {
                appCtrl.isTheme = val;

                appCtrl.update();
                ThemeService().switchTheme(appCtrl.isTheme);
                Get.forceAppUpdate();
              }

            })
      ])
    ]).marginOnly(
        left: Insets.i30, bottom: Insets.i50, right: Insets.i30);
  }
}
