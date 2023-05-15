import '../../../../config.dart';

class PasswordStrengthSlider extends StatelessWidget {
  const PasswordStrengthSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<PasswordController>(
      builder: (passwordCtrl) {
        return SfSliderTheme(
            data: SfSliderThemeData(
                activeTickColor: appCtrl.appTheme.primary,
                overlayRadius: 0,
                inactiveTrackHeight: 3,
                thumbRadius: 5,
                activeTrackHeight: 3),
            child: SfSlider(
                min: 0,
                max: 2,
                value: passwordCtrl.strengthValue,
                stepSize: 1,
                interval: 1,
                showTicks: true,
                inactiveColor: appCtrl.appTheme.textField,
                onChanged: (dynamic newValue) {
                  passwordCtrl.strengthValue = newValue;
                  passwordCtrl.update();
                })).paddingSymmetric(horizontal: Insets.i10);
      }
    );
  }
}
