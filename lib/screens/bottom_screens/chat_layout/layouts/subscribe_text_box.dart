
import '../../../../config.dart';

class SubscribeTextBox extends StatelessWidget {
  const SubscribeTextBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      int balance = appCtrl.envConfig["balance"];

      return Column(
        children: [
          appCtrl.isLocalChatApi == false && balance != 0
              ? Column(
                  children: [
                    Text(
                        appFonts
                            .thereAreAwardLeft(
                                appCtrl.envConfig["balance"].toString())
                            .tr,
                        style: AppCss.outfitSemiBold14.textColor(appCtrl.isTheme
                            ? appCtrl.appTheme.lightText
                            : appCtrl.appTheme.txt)),
                    const VSpace(Sizes.s10),
                  ],
                )
              : balance != 0
                  ? Column(
                      children: [
                        Text(
                            appFonts
                                .thereAreAwardLeft(
                                    appCtrl.envConfig["balance"].toString())
                                .tr,
                            style: AppCss.outfitSemiBold14.textColor(
                                appCtrl.isTheme
                                    ? appCtrl.appTheme.lightText
                                    : appCtrl.appTheme.txt)),
                        const VSpace(Sizes.s10),
                      ],
                    )
                  : Container(),
          if (appCtrl.envConfig["balance"] == 0)
            LimitOverLayout(onTap: () {
              if (appCtrl.firebaseConfigModel!.isGoogleAdmobEnable!) {
                appCtrl.showRewardedAd();
              } else {
                appCtrl.showFacebookRewardedAd();
              }
            }),
          if (appCtrl.envConfig["balance"] != 0) const ChatLayoutTextBox()
        ],
      );
    });
  }
}
