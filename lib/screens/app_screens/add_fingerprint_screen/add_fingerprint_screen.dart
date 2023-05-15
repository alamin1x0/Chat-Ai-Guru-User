import '../../../config.dart';

class AddFingerprintScreen extends StatelessWidget {
  final addFingerprintCtrl = Get.put(AddFingerprintController());

  AddFingerprintScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddFingerprintController>(builder: (_) {
      return DirectionalityRtl(
        child: Scaffold(
            backgroundColor: appCtrl.appTheme.white,
            appBar: AppAppBarCommon(
                title: appFonts.addFingerprint.tr, leadingOnTap: () => Get.back()),
            body: SingleChildScrollView(
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: Sizes.s238,
                            child: Text(appFonts.placeYourFinger.tr,
                                textAlign: TextAlign.center,
                                style: AppCss.outfitMedium22
                                    .textColor(appCtrl.appTheme.txt)
                                    .textHeight(1.2))),
                        const VSpace(Sizes.s8),
                        Text(appFonts.pressTheSensor.tr,
                            style: AppCss.outfitMedium14
                                .textColor(appCtrl.appTheme.lightText)),
                        const VSpace(Sizes.s100),
                        Image.asset(appCtrl.isUserThemeChange
                            ? appCtrl.isUserTheme
                            ? eGifAssets.darkFingerprint
                            : eGifAssets.fingerprint
                            : appCtrl.isTheme
                            ? eGifAssets.darkFingerprint
                            : eGifAssets.fingerprint, height: Sizes.s240)
                      ]).paddingSymmetric(
                      horizontal: Insets.i20, vertical: Insets.i40)),
            )),
      );
    });
  }
}
