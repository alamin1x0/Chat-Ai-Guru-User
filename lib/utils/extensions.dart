import 'package:probot/config.dart';

extension ProbotExtensions on Widget {
  //Auth container extension
  Widget authBoxExtension() => Container(child: this).decorated(
      color: appCtrl.appTheme.boxBg,
      boxShadow: [
        BoxShadow(
            color: appCtrl.isTheme
                ? appCtrl.appTheme.trans
                : appCtrl.appTheme.primary.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4)
      ],
      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.r10)),
      border: Border.all(
          color: appCtrl.isTheme
              ? appCtrl.appTheme.trans
              : appCtrl.appTheme.primary.withOpacity(0.1),
          width: 2));

  Widget descriptionOptionBg() =>
      Container(child: this).paddingAll(Insets.i8).decorated(
          color: appCtrl.appTheme.primaryLight,
          borderRadius: BorderRadius.circular(AppRadius.r4));

  Widget subscribeExtension() => Container(child: this).decorated(
          color: appCtrl.appTheme.white,
          borderRadius: BorderRadius.circular(AppRadius.r10),
          border: Border.all(color: appCtrl.appTheme.borderColor),
          boxShadow: [
            BoxShadow(
                color: appCtrl.appTheme.primaryShadow,
                offset: const Offset(0, 10),
                blurRadius: 20)
          ]);

  Widget chatBgExtension(dynamic image) =>
      Container(child: this).backgroundImage(DecorationImage(
          image: AssetImage(image == null
              ? appCtrl.isUserThemeChange
                  ? appCtrl.isUserTheme
                      ? eImageAssets.dBg1
                      : eImageAssets.background1
                  : appCtrl.isTheme
                      ? eImageAssets.dBg1
                      : eImageAssets.background1
              : appCtrl.isUserThemeChange
                  ? appCtrl.isUserTheme
                      ? image["darkImage"]
                      : image["image"]
                  : appCtrl.isTheme
                      ? image["darkImage"]
                      : image["image"]),
          fit: BoxFit.fill));

  Widget bottomNavExtension()=> Container(child: this).decorated(

          color: appCtrl.appTheme.boxBg,
          boxShadow:  [
            BoxShadow(
                color:appCtrl.appTheme.borderColor,
                blurRadius: 20,
                offset:const Offset(4, -1))
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppRadius.r10),
              topRight:
              Radius.circular(AppRadius.r10))
  );

  Widget selectAmountExtension()=> Container(child: this).decorated(
      color: appCtrl.appTheme.white,
      borderRadius: BorderRadius.circular(AppRadius.r10),
      border: Border.all(color: appCtrl.appTheme.primaryLight1),
      boxShadow: [
        BoxShadow(
            color: appCtrl.isTheme
                ? appCtrl.appTheme.trans
                : appCtrl.appTheme.primary.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4)
      ]);

  Widget tableExtension()=> Container(child: this).decorated(
      border: Border(
          left: BorderSide(
              color: appCtrl.appTheme.primaryLightBorder)));

  Widget planExtension(color)=> Container(child: this).decorated(
      color: color,
      borderRadius: const SmoothBorderRadius.only(
          topLeft: SmoothRadius(
              cornerRadius: 10, cornerSmoothing: 1),
          topRight: SmoothRadius(
              cornerRadius: 10,
              cornerSmoothing: 1))
  );

  Widget planListExtension()=> Container(child: this).decorated(
      color: appCtrl.appTheme.white,
      borderRadius: BorderRadius.circular(
          AppRadius.r10),
      boxShadow: [
  BoxShadow(
  color: appCtrl.isTheme
  ? appCtrl.appTheme.trans
      : appCtrl.appTheme.primary
      .withOpacity(0.1),
  spreadRadius: 1,
  blurRadius: 4)]);

}





removeAllKey() {
  appCtrl.storage.remove(session.envConfig);
  appCtrl.storage.remove(session.isGuestLogin);
  appCtrl.storage.remove(session.selectedCharacter);
  appCtrl.storage.remove(session.isLogin);
  appCtrl.storage.remove(session.isBiometric);
}
