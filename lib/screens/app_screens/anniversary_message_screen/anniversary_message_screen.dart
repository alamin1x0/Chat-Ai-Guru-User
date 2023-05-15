import '../../../config.dart';

class AnniversaryMessageScreen extends StatelessWidget {
  final anniCtrl = Get.put(AnniversaryMessageController());

  AnniversaryMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnniversaryMessageController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Form(
                  key: anniCtrl.scaffoldKey,
                  child: Scaffold(
                      backgroundColor: appCtrl.appTheme.bg1,
                      resizeToAvoidBottomInset: false,
                      appBar: AppAppBarCommon(
                          title: appFonts.anniversaryMessage,
                          leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                      body: Stack(children: [
                        SingleChildScrollView(
                            child: anniCtrl.isMessageGenerate == true
                                ? Column(children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          textCommon.outfitSemiBoldPrimary16(
                                              text: appFonts.goodWishesOn),
                                          const VSpace(Sizes.s15),
                                          InputLayout(
                                              hintText: "",
                                              title: appFonts.generatedWishes,
                                              color: appCtrl.appTheme.white,
                                              isMax: false,
                                              text: anniCtrl.response,
                                              responseText: anniCtrl.response),
                                          const VSpace(Sizes.s20),
                                          ButtonCommon(
                                              title: appFonts
                                                  .endAnniversaryMessage,
                                              onTap: () =>
                                                  anniCtrl.endNameSuggestion()),
                                          const VSpace(Sizes.s30),
                                          const AdCommonLayout()
                                              .backgroundColor(
                                                  appCtrl.appTheme.error)
                                        ])
                                  ]).paddingSymmetric(
                                    vertical: Insets.i30,
                                    horizontal: Insets.i20)
                                : const AnniversaryMessageLayout()),
                        if (anniCtrl.isLoader == true) const LoaderLayout()
                      ])))));
    });
  }
}
