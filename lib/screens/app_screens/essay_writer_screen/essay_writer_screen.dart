import '../../../config.dart';

class EssayWriterScreen extends StatelessWidget {
  final essayWriterCtrl = Get.put(EssayWriterController());

  EssayWriterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EssayWriterController>(builder: (essayWriterCtrl) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Scaffold(
                  backgroundColor: appCtrl.appTheme.bg1,
                  resizeToAvoidBottomInset: false,
                  appBar: AppAppBarCommon(
                      title: appFonts.essayWriting,
                      leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                  body: Stack(children: [
                    essayWriterCtrl.isEssayGenerated == true
                        ? SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                Column(children: [
                                  textCommon.outfitSemiBoldPrimary16(
                                      text: appFonts.outExpertHave),
                                  const VSpace(Sizes.s10),
                                  InputLayout(
                                      hintText: "",
                                      title: appFonts.essayWriting,
                                      isMax: false,
                                      color: appCtrl.appTheme.white,
                                      text: essayWriterCtrl.response,
                                      responseText: essayWriterCtrl.response),
                                  const VSpace(Sizes.s30),
                                  const AdCommonLayout()
                                      .backgroundColor(appCtrl.appTheme.error)
                                ]),
                                const VSpace(Sizes.s30),
                                ButtonCommon(
                                    title: appFonts.endEssayWriting,
                                    onTap: () =>
                                        essayWriterCtrl.endEssayWriterDialog())
                              ]).paddingSymmetric(
                                horizontal: Insets.i20, vertical: Insets.i30))
                        : const EssayGenerateLayout(),
                    if (essayWriterCtrl.isEssayGenerated == false)
                      AdCommonLayout(
                          bannerAd: essayWriterCtrl.bannerAd,
                          bannerAdIsLoaded: essayWriterCtrl.bannerAdIsLoaded,
                          currentAd: essayWriterCtrl.currentAd),
                    if (essayWriterCtrl.isLoader == true) const LoaderLayout()
                  ]))));
    });
  }
}
