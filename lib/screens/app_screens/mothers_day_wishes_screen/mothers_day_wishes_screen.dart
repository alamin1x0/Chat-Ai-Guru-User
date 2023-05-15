import '../../../config.dart';

class MothersDayWishesScreen extends StatelessWidget {
  final motherDayCtrl = Get.put(MothersDayWishesController());

  MothersDayWishesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MothersDayWishesController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Form(
                  key: motherDayCtrl.scaffoldKey,
                  child: Scaffold(
                      backgroundColor: appCtrl.appTheme.bg1,
                      resizeToAvoidBottomInset: false,
                      appBar: AppAppBarCommon(
                          title: appFonts.mothersDayWishes,
                          leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                      body: Stack(children: [
                        SingleChildScrollView(
                            child: motherDayCtrl.isWishesGenerate == true
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        textCommon.outfitSemiBoldPrimary16(
                                            text: appFonts.heartfeltWishes),
                                        const VSpace(Sizes.s15),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InputLayout(
                                                  hintText: "",
                                                  title:
                                                      appFonts.mothersDayWishes,
                                                  color: appCtrl.appTheme.white,
                                                  isMax: false,
                                                  text: motherDayCtrl.response,
                                                  responseText:
                                                      motherDayCtrl.response),
                                              const VSpace(Sizes.s20),
                                              ButtonCommon(
                                                  title: appFonts.endMotherDay,
                                                  onTap: () => motherDayCtrl
                                                      .endWishGenerator()),
                                              const VSpace(Sizes.s30),
                                              const AdCommonLayout()
                                                  .backgroundColor(
                                                      appCtrl.appTheme.error)
                                            ])
                                      ]).paddingSymmetric(
                                    horizontal: Insets.i20,
                                    vertical: Insets.i30)
                                : const MothersDayWishesLayout()),
                        if (motherDayCtrl.isWishesGenerate == false)
                          AdCommonLayout(
                              bannerAd: motherDayCtrl.bannerAd,
                              bannerAdIsLoaded: motherDayCtrl.bannerAdIsLoaded,
                              currentAd: motherDayCtrl.currentAd),
                        if (motherDayCtrl.isLoader == true) const LoaderLayout()
                      ])))));
    });
  }
}
