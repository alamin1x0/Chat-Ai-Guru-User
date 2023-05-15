import '../../../config.dart';

class ManageApiKeyScreen extends StatelessWidget {
  final manageApiCtrl = Get.put(ManageApiController());

  ManageApiKeyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageApiController>(builder: (_) {
      return DirectionalityRtl(
          child: Scaffold(
              backgroundColor: appCtrl.appTheme.bg1,
              appBar: AppAppBarCommon(
                  title: appFonts.manageApiKey,
                  leadingOnTap: () =>
                      Get.offAllNamed(routeName.addApiKeyScreen)),
              body: Column(children: [
                Column(children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        textCommon.outfitSemiBoldTxt14(text: appFonts.apiKey),
                        const VSpace(Sizes.s10),
                        TextFieldCommon(
                            hintText: appFonts.enterYourApi,
                            controller: manageApiCtrl.manageApiController)
                      ]).paddingSymmetric(horizontal: Insets.i15),
                  DottedLines(color: appCtrl.appTheme.txt.withOpacity(0.10))
                      .paddingSymmetric(vertical: Insets.i15),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(appFonts.note.tr,
                            style: AppCss.outfitMedium16
                                .textColor(appCtrl.appTheme.primary)),
                        const VSpace(Sizes.s15),
                        ApiNotesLayout(title: appFonts.yourMobileDevices)
                      ]).paddingSymmetric(horizontal: Insets.i15)
                ]).paddingSymmetric(vertical: Insets.i20).authBoxExtension(),
                const VSpace(Sizes.s30),
                ButtonCommon(
                    title: appFonts.removeApiKey,
                    onTap: () => manageApiCtrl.onRemoveKey())
              ]).paddingSymmetric(
                  vertical: Insets.i30, horizontal: Insets.i20)));
    });
  }
}
