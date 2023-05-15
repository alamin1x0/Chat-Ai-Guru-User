import '../../../config.dart';

class PasswordGeneratorScreen extends StatelessWidget {
  final passwordCtrl = Get.put(PasswordController());

  PasswordGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Scaffold(
                  appBar: AppAppBarCommon(
                      title: appFonts.passwordGenerator,
                      leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                  body: Stack(children: [
                    SingleChildScrollView(
                        child: Column(children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textCommon.outfitSemiBoldPrimary16(
                                text: appFonts.getTheStrong),
                            const VSpace(Sizes.s15),
                            const PasswordLayout(),
                            const VSpace(Sizes.s30),
                            if (passwordCtrl.isPasswordGenerated != true)
                              ButtonCommon(
                                  title: appFonts.buildSomeMagic,
                                  onTap: () =>
                                      passwordCtrl.onPasswordGenerate()),
                            const VSpace(Sizes.s30),
                            const AdCommonLayout()
                                .backgroundColor(appCtrl.appTheme.error),
                            if (passwordCtrl.isPasswordGenerated == true)
                              Column(children: [
                                InputLayout(
                                    color: appCtrl.appTheme.white,
                                    title: appFonts.generatedPassword,
                                    isMax: false,
                                    text: passwordCtrl.response,
                                    responseText: passwordCtrl.response),
                                const VSpace(Sizes.s20),
                                ButtonCommon(
                                    title: appFonts.endPasswordGenerator,
                                    onTap: () => passwordCtrl
                                        .endPasswordGeneratorDialog()),
                                const VSpace(Sizes.s30),
                                const AdCommonLayout()
                                    .backgroundColor(appCtrl.appTheme.error)
                              ])
                          ])
                    ]).paddingSymmetric(
                            vertical: Insets.i30, horizontal: Insets.i20)),
                    if (passwordCtrl.isPasswordGenerated != true)
                      AdCommonLayout(
                          bannerAd: passwordCtrl.bannerAd,
                          bannerAdIsLoaded: passwordCtrl.bannerAdIsLoaded,
                          currentAd: passwordCtrl.currentAd),
                    if (passwordCtrl.isLoader == true) const LoaderLayout()
                  ]))));
    });
  }
}
