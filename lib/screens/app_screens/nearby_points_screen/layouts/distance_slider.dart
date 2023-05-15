import '../../../../config.dart';

class DistanceSlider extends StatelessWidget {
  const DistanceSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearbyPointsController>(builder: (nearbyPointCtrl) {
      return SfRangeSliderTheme(
          data: SfRangeSliderThemeData(
              overlayRadius: 0,
              activeTrackHeight: 3,
              inactiveTrackHeight: 3,
              inactiveLabelStyle:
                  AppCss.outfitSemiBold12.textColor(appCtrl.appTheme.lightText),
              activeLabelStyle:
                  AppCss.outfitSemiBold12.textColor(appCtrl.appTheme.primary),
              tooltipBackgroundColor: appCtrl.appTheme.primary,
              inactiveTickColor: appCtrl.appTheme.textField,
              activeMinorTickColor: appCtrl.appTheme.textField,
              inactiveTrackColor: appCtrl.appTheme.textField,
              inactiveMinorTickColor: appCtrl.appTheme.textField,
              activeTickColor: appCtrl.appTheme.lightText,
              thumbColor: appCtrl.appTheme.trans),
          child: SfRangeSlider(
              min: 0,
              max: 40,
              stepSize: 5,
              startThumbIcon: SvgPicture.asset(eSvgAssets.passwordThumb),
              endThumbIcon: SvgPicture.asset(eSvgAssets.passwordThumb),
              values: nearbyPointCtrl.values,
              interval: 5,
              shouldAlwaysShowTooltip: true,
              minorTicksPerInterval: 3,
              showLabels: true,
              onChanged: (SfRangeValues value) {
                nearbyPointCtrl.values = value;
                nearbyPointCtrl.update();
              }));
    });
  }
}
