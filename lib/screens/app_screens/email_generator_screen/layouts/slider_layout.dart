import 'dart:developer';

import '../../../../config.dart';

class SliderLayout extends StatelessWidget {
  const SliderLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<EmailGeneratorController>(
      builder: (emailGeneratorCtrl) {
        return SfSliderTheme(
            data: SfSliderThemeData(

                overlayRadius: 0,
                inactiveTrackHeight: 3,
                activeTrackHeight: 3),
            child: SfSlider(
                min: 0,
                max: 2,
                value: emailGeneratorCtrl.value,
                stepSize: 1,
                interval: 1,
                showTicks: true,
                minorTicksPerInterval: 15,
                inactiveColor: appCtrl.appTheme.textField,
                tickShape: SfTickShapes(),
                minorTickShape: SfMinorTickShapes(),
                thumbShape: SfThumbShapes(),
                onChanged: (dynamic newValue) {
                  emailGeneratorCtrl.value = newValue;
                  log("new $newValue");
                  emailGeneratorCtrl.update();
                }));
      }
    );
  }
}
