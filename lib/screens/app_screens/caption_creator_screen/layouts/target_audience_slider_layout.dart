import '../../../../config.dart';

class TargetAudienceSliderLayout extends StatelessWidget {
  const TargetAudienceSliderLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialMediaController>(builder: (socialMediaCtrl) {
      return SfRangeSliderTheme(
              data: SfRangeSliderThemeData(
                  activeTrackHeight: 3,
                  inactiveTrackHeight: 3,
                  inactiveLabelStyle: AppCss.outfitSemiBold12
                      .textColor(appCtrl.appTheme.lightText),
                  activeLabelStyle: AppCss.outfitSemiBold12
                      .textColor(appCtrl.appTheme.primary),
                  activeTickColor: appCtrl.appTheme.primary,
                  inactiveTickColor: appCtrl.appTheme.textField,
                  inactiveTrackColor: appCtrl.appTheme.textField,
                  thumbColor: appCtrl.appTheme.white),
              child: SfRangeSlider(
                  min: 20,
                  max: 60,
                  stepSize: 5,
                  startThumbIcon: SvgPicture.asset(eSvgAssets.sliderThumb),
                  endThumbIcon: SvgPicture.asset(eSvgAssets.sliderThumb),
                  values: socialMediaCtrl.values,
                  interval: 5,
                  showTicks: true,
                  showLabels: true,
                  onChanged: (SfRangeValues value) {
                    socialMediaCtrl.values = value;
                    socialMediaCtrl.update();
                  }))
          .paddingSymmetric(vertical: Insets.i20)
          .authBoxExtension()
          .paddingOnly(top: Insets.i10, bottom: Insets.i20);
    });
  }
}
