import '../../../config.dart';

class NewYearGreetingScreen extends StatelessWidget {
  final newYearCtrl = Get.put(NewYearGreetingController());

  NewYearGreetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewYearGreetingController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Form(
                  key: newYearCtrl.scaffoldKey,
                  child: Scaffold(
                      backgroundColor: appCtrl.appTheme.bg1,
                      resizeToAvoidBottomInset: false,
                      appBar: AppAppBarCommon(
                          title: appFonts.newYearGreeting,
                          leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                      body: Stack(children: [
                        SingleChildScrollView(
                            child: newYearCtrl.isGreetingGenerate == true
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        textCommon.outfitSemiBoldPrimary16(
                                            text: appFonts.dazzlingBestWishes),
                                        const VSpace(Sizes.s15),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InputLayout(
                                                  hintText: "",
                                                  title:
                                                      appFonts.newYearGreeting,
                                                  color: appCtrl.appTheme.white,
                                                  isMax: false,
                                                  text: newYearCtrl.response,
                                                  responseText:
                                                      newYearCtrl.response),
                                              const VSpace(Sizes.s20),
                                              ButtonCommon(
                                                  title: appFonts.endWellWishes,
                                                  onTap: () => newYearCtrl
                                                      .endNewYearGreeting()),
                                              const VSpace(Sizes.s30),
                                              const AdCommonLayout()
                                                  .backgroundColor(
                                                      appCtrl.appTheme.error)
                                            ])
                                      ]).paddingSymmetric(
                                    horizontal: Insets.i20,
                                    vertical: Insets.i30)
                                : const NewYearGreetingLayout()),
                        if (newYearCtrl.isGreetingGenerate == false)
                          AdCommonLayout(
                              bannerAd: newYearCtrl.bannerAd,
                              bannerAdIsLoaded: newYearCtrl.bannerAdIsLoaded,
                              currentAd: newYearCtrl.currentAd),
                        if (newYearCtrl.isLoader == true) const LoaderLayout()
                      ])))));
    });
  }
}
