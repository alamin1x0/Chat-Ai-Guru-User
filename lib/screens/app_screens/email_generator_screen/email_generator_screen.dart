import '../../../config.dart';

class EmailGeneratorScreen extends StatelessWidget {
  final emailGeneratorCtrl = Get.put(EmailGeneratorController());

  EmailGeneratorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmailGeneratorController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: AppAppBarCommon(
                      title: appFonts.emailWriter,
                      leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                  body: Stack(children: [
                    SingleChildScrollView(
                        child: emailGeneratorCtrl.isMailGenerated == true
                            ? Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(appFonts.weCreatedLetter.tr,
                                              style: AppCss.outfitSemiBold16
                                                  .textColor(appCtrl
                                                      .appTheme.primary)),
                                          const VSpace(Sizes.s15),
                                          InputLayout(
                                              color: appCtrl.appTheme.white,
                                              title: appFonts.generatedMail,
                                              isMax: false,
                                              responseText:
                                                  emailGeneratorCtrl.response,
                                              text: emailGeneratorCtrl.response)
                                        ]),
                                    const VSpace(Sizes.s30),
                                    ButtonCommon(
                                        title: appFonts.endEmailWriter,
                                        onTap: () => emailGeneratorCtrl
                                            .endEmailGeneratorDialog()),
                                    const VSpace(Sizes.s30),
                                    const AdCommonLayout().backgroundColor(
                                        appCtrl.appTheme.error),
                                  ]).paddingSymmetric(
                                vertical: Insets.i30, horizontal: Insets.i20)
                            : const GeneratedMailLayout()),
                    if (emailGeneratorCtrl.isLoader == true)
                      const LoaderLayout()
                  ]))));
    });
  }
}
