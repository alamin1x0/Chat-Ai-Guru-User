import '../../../../config.dart';

class ContentCommonWidget {
  //common border
  OutlineInputBorder commonBorder() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.r8),
      borderSide: BorderSide.none);

  //common text
  Widget commonText(text) => Text(text.toString().tr,
      style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt));
}
