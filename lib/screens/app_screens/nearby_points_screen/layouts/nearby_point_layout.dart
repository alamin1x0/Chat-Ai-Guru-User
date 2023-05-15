import '../../../../config.dart';

class NearbyPointLayout extends StatelessWidget {
  const NearbyPointLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearbyPointsController>(builder: (nearbyPointCtrl) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          textCommon.outfitSemiBoldPrimary16(
              text: appFonts.visitWonderfulLocations),
          const VSpace(Sizes.s15),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            MusicCategoryLayout(
                title: appFonts.iAmLooking,
                category: nearbyPointCtrl.placeOnSelect ?? "Restaurant",
                onTap: () => nearbyPointCtrl.onPlaceSheet()),
            const VSpace(Sizes.s20),
            MusicCategoryLayout(
                title: appFonts.myCurrentLocation,
                category: nearbyPointCtrl.onSelect ?? "Surat",
                onTap: () => nearbyPointCtrl.onCitySheet()),
            const VSpace(Sizes.s20),
            textCommon.outfitSemiBoldTxt14(text: appFonts.distanceFrom),
            const VSpace(Sizes.s60),
            const DistanceSlider()
          ])
              .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
              .authBoxExtension()
        ]),
        const VSpace(Sizes.s30),
        ButtonCommon(
            title: appFonts.takeMeTo,
            onTap: () => nearbyPointCtrl.onNearbyPointGenerate())
      ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20);
    });
  }
}
