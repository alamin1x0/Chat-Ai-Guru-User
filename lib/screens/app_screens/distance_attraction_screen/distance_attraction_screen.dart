import '../../../config.dart';

class DistanceAttractionScreen extends StatelessWidget {
  final distanceCtrl = Get.put(DistanceAttractionController());

  DistanceAttractionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistanceAttractionController>(builder: (distanceCtrl) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Scaffold(
                  backgroundColor: appCtrl.appTheme.bg1,
                  appBar: AppAppBarCommon(
                      title: appFonts.distanceAttraction,
                      leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                  body: Stack(children: [
                    SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          distanceCtrl.isDistanceGenerated == false
                              ? const DistanceGeneratedLayout()
                              : Column(children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textCommon.outfitSemiBoldPrimary16(
                                      text:
                                      appFonts.visitWonderfulLocationsAroundWorld),
                                  const VSpace(Sizes.s15),
                                  InputLayout(
                                      hintText: "",
                                      title: appFonts.distanceAttraction,
                                      color: appCtrl.appTheme.white,
                                      isMax: false,
                                      text: distanceCtrl.response,
                                      responseText: distanceCtrl.response)
                                ]),
                            const VSpace(Sizes.s20),
                            ButtonCommon(
                                title: appFonts.endTraveling,
                                onTap: () => distanceCtrl.endDistanceGenerator())
                          ])
                        ]).paddingSymmetric(
                            vertical: Insets.i30, horizontal: Insets.i20)),
                    if (distanceCtrl.isDistanceGenerated == false)
                      AdCommonLayout(
                          bannerAd: distanceCtrl.bannerAd,
                          bannerAdIsLoaded: distanceCtrl.bannerAdIsLoaded,
                          currentAd: distanceCtrl.currentAd),
                    if (distanceCtrl.isLoader == true) const LoaderLayout()
                  ]))));
    });
  }
}
