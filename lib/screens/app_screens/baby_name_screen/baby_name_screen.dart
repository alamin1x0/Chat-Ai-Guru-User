import '../../../config.dart';

class BabyNameScreen extends StatelessWidget {
  final babyCtrl = Get.put(BabyNameSuggestionController());

  BabyNameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BabyNameSuggestionController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => babyCtrl.onTapClearCtrlTTS(),
          child: DirectionalityRtl(
              child: Form(
                  key: babyCtrl.scaffoldKey,
                  child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: appCtrl.appTheme.bg1,
                      appBar: AppAppBarCommon(
                          title: appFonts.babyNameSuggestion,
                          leadingOnTap: () {
                            babyCtrl.latterController.clear();
                            babyCtrl.generatedNameController.clear();
                            textToSpeechCtrl.onStopTTS();
                            babyCtrl.update();
                          }),
                      body: Stack(children: [
                        SingleChildScrollView(
                            child: Column(children: [
                          babyCtrl.isNameGenerate == false
                              ? const BabyNameTopLayout()
                              : Column(children: [
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        textCommon.outfitSemiBoldPrimary16(
                                            text: appFonts.someCuteNames),
                                        const VSpace(Sizes.s15),
                                        InputLayout(
                                            hintText: "",
                                            title: appFonts.babyName,
                                            color: appCtrl.appTheme.white,
                                            isMax: false,
                                            text: babyCtrl.response,
                                            responseText: babyCtrl.response)
                                      ]),
                                  const VSpace(Sizes.s20),
                                  ButtonCommon(
                                      title: appFonts.endNameSuggestion,
                                      onTap: () =>
                                          babyCtrl.endNameSuggestion()),
                                  const VSpace(Sizes.s30),
                                  const AdCommonLayout()
                                      .backgroundColor(appCtrl.appTheme.error)
                                ])
                        ]).paddingSymmetric(
                                vertical: Insets.i30, horizontal: Insets.i20)),
                        if (babyCtrl.isNameGenerate == false)
                          AdCommonLayout(
                              bannerAd: babyCtrl.bannerAd,
                              bannerAdIsLoaded: babyCtrl.bannerAdIsLoaded,
                              currentAd: babyCtrl.currentAd),
                        if (babyCtrl.isLoader == true) const LoaderLayout()
                      ])))));
    });
  }
}
