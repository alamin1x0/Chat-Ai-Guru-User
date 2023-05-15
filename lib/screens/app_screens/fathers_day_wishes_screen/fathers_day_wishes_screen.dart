import '../../../config.dart';

class FathersDayWishesScreen extends StatelessWidget {
  final fatherCtrl = Get.put(FathersDayWishesController());

  FathersDayWishesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FathersDayWishesController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Form(
                  key: fatherCtrl.scaffoldKey,
                  child: Scaffold(
                      backgroundColor: appCtrl.appTheme.bg1,
                      resizeToAvoidBottomInset: false,
                      appBar: AppAppBarCommon(
                          title: appFonts.fathersDayWishes,
                          leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                      body: Stack(children: [
                        SingleChildScrollView(
                            child: fatherCtrl.isWishesGenerate == true
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        textCommon.outfitSemiBoldPrimary16(
                                            text: appFonts.warmestRegards),
                                        const VSpace(Sizes.s15),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InputLayout(
                                                  hintText: "",
                                                  title:
                                                      appFonts.fathersDayWishes,
                                                  color: appCtrl.appTheme.white,
                                                  isMax: false,
                                                  text: fatherCtrl.response,
                                                  responseText:
                                                      fatherCtrl.response),
                                              const VSpace(Sizes.s20),
                                              ButtonCommon(
                                                  title: appFonts.endFathersDay,
                                                  onTap: () => fatherCtrl
                                                      .endWishGenerator()),
                                              const VSpace(Sizes.s30),
                                              const AdCommonLayout()
                                                  .backgroundColor(
                                                      appCtrl.appTheme.error)
                                            ])
                                      ]).paddingSymmetric(
                                    horizontal: Insets.i20,
                                    vertical: Insets.i30)
                                : const FathersDayWishesLayout()),
                        if (fatherCtrl.isWishesGenerate == false)
                          AdCommonLayout(
                              bannerAd: fatherCtrl.bannerAd,
                              bannerAdIsLoaded: fatherCtrl.bannerAdIsLoaded,
                              currentAd: fatherCtrl.currentAd),
                        if (fatherCtrl.isLoader == true) const LoaderLayout()
                      ])))));
    });
  }
}
