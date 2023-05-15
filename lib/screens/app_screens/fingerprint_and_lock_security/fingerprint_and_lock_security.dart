import '../../../config.dart';

class FingerprintAndLockSecurity extends StatelessWidget {
  const FingerprintAndLockSecurity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppAppBarCommon(
            title: appFonts.fingerprintLock, leadingOnTap: () => Get.back()),
        body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Column(children: [
                Image.asset(eImageAssets.addFinger,
                    height: Sizes.s360, width: Sizes.s270),
                const VSpace(Sizes.s15),
                Text(appFonts.youHaveNotVerify.tr,
                    style:
                        AppCss.outfitMedium16.textColor(appCtrl.appTheme.txt))
              ]),
              ButtonCommon(
                  title: appFonts.verify,
                  onTap: () => Get.toNamed(routeName.addFingerprintScreen))
            ])
            .paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i40)
            .alignment(Alignment.center));
  }
}
