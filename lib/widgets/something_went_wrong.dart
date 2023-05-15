import '../config.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appCtrl.appTheme.bg1,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(eImageAssets.notification,
                  height: Sizes.s200, width: Sizes.s200, fit: BoxFit.contain),
              const VSpace(Sizes.s20),
              Text(appFonts.somethingWentWrong.tr,
                  style:
                      AppCss.outfitSemiBold16.textColor(appCtrl.appTheme.txt)),
              const VSpace(Sizes.s20),
              ButtonCommon(
                  title: appFonts.tryAgain,
                  onTap: () {
                    snackBarMessengers(
                        message: appFonts.refreshing,
                        color: appCtrl.appTheme.icon);
                  })
            ]).paddingSymmetric(horizontal: Insets.i30));
  }
}
