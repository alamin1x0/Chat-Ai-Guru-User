import '../../../config.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final privacyPolicyCtrl = Get.put(PrivacyPolicyController());

  PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivacyPolicyController>(builder: (_) {
      return Scaffold(
        backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(title: appFonts.privacyTerm),
          body: Column(children: [
            ExpansionTileLayout(
              title: appFonts.description,
               widget: [
                 const DottedLines(),
                 const VSpace(Sizes.s15),
                 Text(appFonts.thisPrivacyPolicy,
                     style: AppCss.outfitMedium14
                         .textColor(appCtrl.appTheme.lightText)
                         .textHeight(1.3))
               ]
            ),
            ExpansionTileLayout(
                title: appFonts.interpretationDefinitions,
                widget: [
                  const DottedLines(),
                  const VSpace(Sizes.s15),
                  Text(appFonts.thisPrivacyPolicy,
                      style: AppCss.outfitMedium14
                          .textColor(appCtrl.appTheme.lightText)
                          .textHeight(1.3))
                ]
            ),
          ]).paddingSymmetric(horizontal: Insets.i20, vertical: Insets.i25));
    });
  }
}
