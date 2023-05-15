import '../../../config.dart';

class FarewellMessageScreen extends StatelessWidget {
  final farewellCtrl = Get.put(FarewellMessageController());

  FarewellMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FarewellMessageController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Form(
                  key: farewellCtrl.scaffoldKey,
                  child: Scaffold(
                      backgroundColor: appCtrl.appTheme.bg1,
                      resizeToAvoidBottomInset: false,
                      appBar: AppAppBarCommon(
                          title: appFonts.farewellMessage,
                          leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                      body: Stack(children: [
                        SingleChildScrollView(
                            child: farewellCtrl.isMessageGenerate == true
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        textCommon.outfitSemiBoldPrimary16(
                                            text: appFonts.aFewWishes),
                                        const VSpace(Sizes.s15),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InputLayout(
                                                  hintText: "",
                                                  title:
                                                      appFonts.farewellMessage,
                                                  color: appCtrl.appTheme.white,
                                                  isMax: false,
                                                  text: farewellCtrl.response,
                                                  responseText:
                                                      farewellCtrl.response),
                                              const VSpace(Sizes.s20),
                                              ButtonCommon(
                                                  title: appFonts
                                                      .endFarewellMessage,
                                                  onTap: () => farewellCtrl
                                                      .endWishGenerator()),
                                              const VSpace(Sizes.s30),
                                              const AdCommonLayout()
                                                  .backgroundColor(
                                                      appCtrl.appTheme.error)
                                            ])
                                      ]).paddingSymmetric(
                                    horizontal: Insets.i20,
                                    vertical: Insets.i30)
                                : const FarewellMessageLayout()),
                        if (farewellCtrl.isMessageGenerate == false)
                          AdCommonLayout(
                              bannerAd: farewellCtrl.bannerAd,
                              bannerAdIsLoaded: farewellCtrl.bannerAdIsLoaded,
                              currentAd: farewellCtrl.currentAd),
                        if (farewellCtrl.isLoader == true) const LoaderLayout()
                      ])))));
    });
  }
}
