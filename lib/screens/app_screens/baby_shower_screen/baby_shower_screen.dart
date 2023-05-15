import '../../../config.dart';

class BabyShowerScreen extends StatelessWidget {
  final babyShowerCtrl = Get.put(BabyShowerController());

  BabyShowerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BabyShowerController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Form(
                  key: babyShowerCtrl.scaffoldKey,
                  child: Scaffold(
                      backgroundColor: appCtrl.appTheme.bg1,
                      resizeToAvoidBottomInset: false,
                      appBar: AppAppBarCommon(
                          title: appFonts.babyShowerMessage,
                          leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                      body: Stack(children: [
                        SingleChildScrollView(
                            child: babyShowerCtrl.isMessageGenerate == true
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        textCommon.outfitSemiBoldPrimary16(
                                            text:
                                                appFonts.congratulatoryMessage),
                                        const VSpace(Sizes.s15),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InputLayout(
                                                  hintText: "",
                                                  title:
                                                      appFonts.babyShowerWishes,
                                                  color: appCtrl.appTheme.white,
                                                  isMax: false,
                                                  text: babyShowerCtrl.response,
                                                  responseText:
                                                      babyShowerCtrl.response),
                                              const VSpace(Sizes.s20),
                                              ButtonCommon(
                                                  title:
                                                      appFonts.endPromotionWish,
                                                  onTap: () => babyShowerCtrl
                                                      .endWishGenerator()),
                                              const VSpace(Sizes.s30),
                                              const AdCommonLayout()
                                                  .backgroundColor(
                                                      appCtrl.appTheme.error)
                                            ])
                                      ]).paddingSymmetric(
                                    horizontal: Insets.i20,
                                    vertical: Insets.i30)
                                : const BabyShowerLayout()),
                        if (babyShowerCtrl.isMessageGenerate == false)
                          AdCommonLayout(
                              bannerAd: babyShowerCtrl.bannerAd,
                              bannerAdIsLoaded: babyShowerCtrl.bannerAdIsLoaded,
                              currentAd: babyShowerCtrl.currentAd),
                        if (babyShowerCtrl.isLoader == true)
                          const LoaderLayout()
                      ])))));
    });
  }
}
