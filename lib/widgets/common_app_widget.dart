
import '../config.dart';

class CommonAppWidgets {
  //column title and value
  Widget columnTitleAndValu(value, {title}) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      if (title != null)
        Text(title.toString().tr,
            textAlign: TextAlign.center,
            style: AppCss.outfitRegular14
                .textColor(appCtrl.appTheme.lightText)),
      if (title != null) const VSpace(Sizes.s3),
      Text(value.toString().tr,textAlign: TextAlign.center,
          style: AppCss.outfitRegular14.textColor(appCtrl.appTheme.txt))
    ],
  );

  TableRow tableRow ()=> TableRow(
      decoration: BoxDecoration(
          color: appCtrl.appTheme.primaryLight2,
          border: Border(
              top: BorderSide(color: appCtrl.appTheme.primaryLightBorder),
              bottom:
              BorderSide(color: appCtrl.appTheme.primaryLightBorder))),
      children: [
        Text(appFonts.advantages.tr,
            style: AppCss.outfitMedium16
                .textColor(appCtrl.appTheme.primary))
            .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i14),
        Text(appFonts.free.tr,
            textAlign: TextAlign.center,
            style: AppCss.outfitMedium14
                .textColor(appCtrl.appTheme.primary))
            .paddingSymmetric(horizontal: Insets.i18, vertical: Insets.i14)
            .tableExtension(),
        Text(appFonts.pro.tr,
            textAlign: TextAlign.center,
            style: AppCss.outfitMedium16
                .textColor(appCtrl.appTheme.primary))
            .paddingSymmetric(horizontal: Insets.i18, vertical: Insets.i14)
            .tableExtension()
      ]);

}