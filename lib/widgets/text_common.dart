import '../config.dart';

class TextCommon {
  outfitSemiBoldPrimary16({text}) {
    return Text(text.toString().tr,
        style: AppCss.outfitBold16.textColor(appCtrl.appTheme.primary));
  }

  outfitSemiBoldTxt14({text}) {
    return Text(text.toString().tr,
        style: AppCss.outfitBold14.textColor(appCtrl.appTheme.txt));
  }

  outfitMediumTxt16({text}) {
    return Text(text.toString().tr,
        style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt));
  }

  simplyUseTextAuth() {
    return Text(appFonts.simplyUseThis.tr,
            textAlign: TextAlign.center,
            style: AppCss.outfitMedium16
                .textColor(appCtrl.appTheme.lightText)
                .textHeight(1.3))
        .alignment(Alignment.bottomCenter)
        .paddingSymmetric(vertical: Insets.i40, horizontal: Insets.i20);
  }

  regularLightText12({text}){
    return Text(text,
        style: AppCss.outfitRegular12
            .textColor(appCtrl.appTheme.lightText));
  }

  outfitMediumPrimary14({text}) {
    return Text(text,
        style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.primary));
  }

  semiBoldPrimary18({text,double? margin}) {
    return Text(text,
        style: AppCss.outfitSemiBold18
            .textColor(appCtrl.appTheme.primary)).marginSymmetric(horizontal: margin ?? 00);
  }

}
