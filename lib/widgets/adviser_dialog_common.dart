import '../config.dart';

class AdviserDialog extends StatelessWidget {
  final String? title,subTitle;
  final GestureTapCallback? endOnTap;
  const AdviserDialog({Key? key,this.title,this.subTitle,this.endOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Material(
            color: appCtrl.appTheme.trans,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              CommonPopUpTitle(title: title!.tr),
              DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1,
                  dashLength: 3,
                  dashColor: appCtrl.appTheme.txt.withOpacity(.1)),
              const VSpace(Sizes.s20),
              Image.asset(eImageAssets.notification, height: Sizes.s180),
              const VSpace(Sizes.s15),
              Text(subTitle!.tr,
                  textAlign: TextAlign.center,
                  style: AppCss.outfitMedium16
                      .textColor(appCtrl.appTheme.txt)
                      .textHeight(1.2)).paddingSymmetric(horizontal: Insets.i20),
              Row(children: [
                Expanded(
                    child: ButtonCommon(
                        title: appFonts.cancel,
                        isGradient: false,
                        style: AppCss.outfitMedium16
                            .textColor(appCtrl.appTheme.primary),
                        color: appCtrl.appTheme.trans,
                        borderColor: appCtrl.appTheme.primary,
                        onTap: () => Get.back())),
                const HSpace(Sizes.s15),
                Expanded(
                    child: ButtonCommon(
                      title: appFonts.end,
                      onTap: endOnTap
                    ))
              ]).paddingSymmetric(
                  horizontal: Insets.i20, vertical: Insets.i20)
            ])
                .decorated(
                color: appCtrl.appTheme.white,
                borderRadius: BorderRadius.circular(AppRadius.r10))
                .marginSymmetric(horizontal: Insets.i20)));
  }
}
