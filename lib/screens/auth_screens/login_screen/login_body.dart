import 'dart:developer';

import '../../../config.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (appCtrl) {
        log("FIRESEBASE : ${appCtrl.firebaseConfigModel!}");
        return Column(children: [
          IntrinsicHeight(
              child: Row(children: [
            VerticalDivider(thickness: 4, width: 1, color: appCtrl.appTheme.primary)
                .backgroundColor(appCtrl.appTheme.error),
            const HSpace(Sizes.s12),
            SizedBox(
                width: MediaQuery.of(context).size.height < 534 ? Sizes.s266 : Sizes.s300,
                child: Text(appFonts.fastResponse.tr,
                    style: AppCss.outfitSemiBold22
                        .textColor(appCtrl.appTheme.txt)
                        .textHeight(1.3)))
          ])),
          const VSpace(Sizes.s20),
          Text(appFonts.aBuddyWhoAvailable.tr,
              style: AppCss.outfitMedium16
                  .textColor(appCtrl.appTheme.lightText)
                  .textHeight(1.3)),
          const VSpace(Sizes.s40),
          Row(children: [
            Expanded(
                child: ButtonCommon(
                    title: appFonts.signUp,
                    onTap: () => Get.toNamed(routeName.signUpScreen))),
            const HSpace(Sizes.s15),
            Expanded(
                child: ButtonCommon(
                    title: appFonts.signIn,
                    onTap: () => Get.toNamed(routeName.signInScreen)))
          ]),
          const OrLayout(),
          if (appCtrl.firebaseConfigModel!.isGuestLoginEnable!)
            Text(appFonts.continueAsAGuest.tr,
                    style:
                        AppCss.outfitMedium16.textColor(appCtrl.appTheme.primary))
                .inkWell(onTap: () {
              appCtrl.isLogin = true;
              appCtrl.isGuestLogin = true;
              appCtrl.storage.write(session.isGuestLogin, true);
              appCtrl.storage.write(
                  session.selectedCharacter, appArray.selectCharacterList[3]);
              Get.offAllNamed(routeName.dashboard);
              appCtrl.update();
            })
        ]);
      }
    );
  }
}
