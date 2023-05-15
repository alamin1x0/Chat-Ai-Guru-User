import '../../../../config.dart';

class DistanceSliderLayout extends StatelessWidget {
  const DistanceSliderLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DistanceAttractionController>(builder: (distanceCtrl) {
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
              inactiveTrackColor: appCtrl.appTheme.textField,
              thumbColor: appCtrl.appTheme.trans),
          child: SfRangeSlider(
              min: 5,
              max: 40,
              stepSize: 5,
              startThumbIcon: SvgPicture.asset(eSvgAssets.distanceThumb),
              endThumbIcon: SvgPicture.asset(eSvgAssets.distanceThumb),
              values: distanceCtrl.values,
              interval: 5,
              shouldAlwaysShowTooltip: true,
              showLabels: true,
              onChanged: (SfRangeValues value) {
                distanceCtrl.values = value;
                distanceCtrl.update();
              }));
    });
  }
}
