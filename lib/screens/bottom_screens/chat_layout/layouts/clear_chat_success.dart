import '../../../../config.dart';

class ClearChatSuccess extends StatelessWidget {
  const ClearChatSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: appCtrl.appTheme.trans,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(appFonts.clearSuccessFully.tr,
                      style: AppCss.outfitblack20
                          .textColor(appCtrl.appTheme.txt)
                          .textDecoration(TextDecoration.none))
                  .paddingSymmetric(horizontal: Insets.i20),
              InkWell(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    eSvgAssets.cancel,
                    height: Sizes.s24,
                  ))
            ],
          ).paddingAll(Insets.i20),
          DottedLine(
              direction: Axis.horizontal,
              lineLength: double.infinity,
              lineThickness: 1,
              dashLength: 3,
              dashColor: appCtrl.appTheme.txt.withOpacity(.2)),
          const VSpace(Sizes.s25),
          Image.asset(eImageAssets.success)
              .paddingSymmetric(horizontal: Insets.i70, vertical: Insets.i20),
          const VSpace(Sizes.s10),
          Text(appFonts.deleteChat.tr,textAlign: TextAlign.center,
              style: AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt)).paddingSymmetric(horizontal: Insets.i30),

          const VSpace(Sizes.s20),
          ButtonCommon(title: appFonts.okay,margin: 20,onTap: ()=> Get.back(),),
          const VSpace(Sizes.s25)
        ],
      )
          .decorated(
              color: appCtrl.appTheme.white,
              borderRadius: BorderRadius.circular(AppRadius.r10))
          .marginSymmetric(horizontal: Insets.i20),
    );
  }
}
