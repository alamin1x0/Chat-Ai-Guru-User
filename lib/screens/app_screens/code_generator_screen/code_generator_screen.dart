import '../../../config.dart';

class CodeGeneratorScreen extends StatelessWidget {
  final codeGeneratorCtrl = Get.put(CodeGeneratorController());

  CodeGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CodeGeneratorController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: appCtrl.appTheme.bg1,
                  appBar: AppAppBarCommon(
                      title: appFonts.codeGenerator,
                      leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                  body: Stack(alignment: Alignment.bottomCenter, children: [
                    codeGeneratorCtrl.isCodeGenerate == true
                        ? SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(appFonts.weCreatedIncredible.tr,
                                          style: AppCss.outfitSemiBold16
                                              .textColor(
                                                  appCtrl.appTheme.primary)),
                                      const VSpace(Sizes.s23),
                                      InputLayout(
                                          color: appCtrl.appTheme.white,
                                          title: appFonts.generatedCode,
                                          isMax: false,
                                          text: codeGeneratorCtrl.response,
                                          responseText:
                                              codeGeneratorCtrl.response)
                                    ]),
                                const VSpace(Sizes.s30),
                                ButtonCommon(
                                    title: appFonts.endCodeGenerator,
                                    onTap: () => codeGeneratorCtrl
                                        .endCodeGeneratorDialog())
                              ]).paddingSymmetric(
                                horizontal: Insets.i20, vertical: Insets.i30))
                        : const CodeGeneratorLayout(),
                    if (codeGeneratorCtrl.isCodeGenerate == false)
                      AdCommonLayout(
                          bannerAd: codeGeneratorCtrl.bannerAd,
                          bannerAdIsLoaded: codeGeneratorCtrl.bannerAdIsLoaded,
                          currentAd: codeGeneratorCtrl.currentAd),
                    if (codeGeneratorCtrl.isLoader == true) const LoaderLayout()
                  ]))));
    });
  }
}
