import '../../../config.dart';

class NearbyPointsScreen extends StatelessWidget {
  final nearbyPointCtrl = Get.put(NearbyPointsController());

  NearbyPointsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearbyPointsController>(builder: (_) {
      return WillPopScope(
          onWillPop: () async {
            textToSpeechCtrl.onStopTTS();
            return true;
          },
          child: DirectionalityRtl(
              child: Scaffold(
                  backgroundColor: appCtrl.appTheme.bg1,
                  appBar: AppAppBarCommon(
                      title: appFonts.nearbyPoints,
                      leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                  body: Stack(children: [
                    SingleChildScrollView(
                        child: nearbyPointCtrl.isNearbyPointsGenerated == false
                            ? const NearbyPointLayout()
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          textCommon.outfitSemiBoldPrimary16(
                                              text: appFonts.weFoundTheMost),
                                          const VSpace(Sizes.s20),
                                          InputLayout(
                                              hintText: "",
                                              title: appFonts
                                                  .someInterestingLocation,
                                              isMax: false,
                                              color: appCtrl.appTheme.white,
                                              text: nearbyPointCtrl.response,
                                              responseText:
                                                  nearbyPointCtrl.response)
                                        ]),
                                    const VSpace(Sizes.s30),
                                    ButtonCommon(
                                        title: appFonts.endTraveling,
                                        onTap: () => nearbyPointCtrl
                                            .endNearbyGeneratorDialog())
                                  ]).paddingSymmetric(
                                vertical: Insets.i30, horizontal: Insets.i20)),
                    if (nearbyPointCtrl.isNearbyPointsGenerated == false)
                      AdCommonLayout(
                          bannerAd: nearbyPointCtrl.bannerAd,
                          bannerAdIsLoaded: nearbyPointCtrl.bannerAdIsLoaded,
                          currentAd: nearbyPointCtrl.currentAd),
                    if (nearbyPointCtrl.isLoader == true) const LoaderLayout()
                  ]))));
    });
  }
}
