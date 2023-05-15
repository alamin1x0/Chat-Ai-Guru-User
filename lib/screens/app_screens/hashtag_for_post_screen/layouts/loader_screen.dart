import '../../../../config.dart';

class LoaderScreen extends StatelessWidget {
  final double? value;

  const LoaderScreen({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(eGifAssets.hashtagLoader, height: Sizes.s170),
              const VSpace(Sizes.s25),
              Text(appFonts.gatheringContent.tr,
                  style:
                      AppCss.outfitSemiBold14.textColor(appCtrl.appTheme.txt)),
              const VSpace(Sizes.s15),
              SizedBox(
                  width: Sizes.s75,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                          backgroundColor: appCtrl.appTheme.textField,
                          valueColor: AlwaysStoppedAnimation<Color>(
                              appCtrl.appTheme.primary),
                          value: value!,
                          minHeight: 4))),
              const VSpace(Sizes.s10),
              Text(appFonts.itMayTakeUpTo.tr,
                  style: AppCss.outfitMedium14
                      .textColor(appCtrl.appTheme.lightText))
            ])
                    .paddingSymmetric(
                        vertical: Insets.i30, horizontal: Insets.i20)
                    .paddingOnly(top: Insets.i50))
        .backgroundColor(appCtrl.appTheme.bg1);
  }
}
