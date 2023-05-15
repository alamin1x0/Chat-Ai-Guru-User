import '../../../../config.dart';

class PasswordLengthSlider extends StatelessWidget {
  const PasswordLengthSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordController>(builder: (passwordCtrl) {
      return SfSliderTheme(
          data: SfSliderThemeData(
              overlayRadius: 0,
              inactiveLabelStyle:
                  AppCss.outfitMedium12.textColor(appCtrl.appTheme.lightText),
              activeLabelStyle:
                  AppCss.outfitMedium12.textColor(appCtrl.appTheme.primary),
              thumbColor: appCtrl.appTheme.trans,
              activeTrackHeight: 3,
              inactiveTrackHeight: 3,
              tooltipTextStyle:
                  AppCss.outfitMedium12.textColor(appCtrl.appTheme.sameWhite),
              tooltipBackgroundColor: appCtrl.appTheme.primary,
              inactiveTrackColor: appCtrl.appTheme.textField),
          child: SfSlider(
              stepSize: 1,
              min: 1,
              max: 20.0,
              interval: 1,
              showLabels: true,
              enableTooltip: true,
              shouldAlwaysShowTooltip: true,
              thumbIcon: SvgPicture.asset(eSvgAssets.passwordThumb),
              value: passwordCtrl.value,
              onChanged: (dynamic newValue) {
                passwordCtrl.value = newValue;
                passwordCtrl.update();
              }));
    });
  }
}
