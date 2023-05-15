import '../../../config.dart';

class BirthdayMessageScreen extends StatelessWidget {
  final birthdayCtrl = Get.put(BirthdayMessageController());

  BirthdayMessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BirthdayMessageController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Form(
                  key: birthdayCtrl.scaffoldKey,
                  child: Scaffold(
                      backgroundColor: appCtrl.appTheme.bg1,
                      resizeToAvoidBottomInset: false,
                      appBar: AppAppBarCommon(
                          title: appFonts.birthdayMessage,
                          leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                      body: Stack(children: [
                        SingleChildScrollView(
                            child: birthdayCtrl.isBirthdayGenerated == true
                                ? Column(children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          textCommon.outfitSemiBoldPrimary16(
                                              text: appFonts.aSpecialDay),
                                          const VSpace(Sizes.s15),
                                          InputLayout(
                                              hintText: "",
                                              title: appFonts.generatedWishes,
                                              color: appCtrl.appTheme.white,
                                              isMax: false,
                                              text: birthdayCtrl.response,
                                              responseText:
                                                  birthdayCtrl.response)
                                        ]),
                                    const VSpace(Sizes.s20),
                                    ButtonCommon(
                                        title: appFonts.endBirthdayMessage,
                                        onTap: () =>
                                            birthdayCtrl.endNameSuggestion()),
                                    const VSpace(Sizes.s30),
                                  ]).paddingSymmetric(
                                    vertical: Insets.i30,
                                    horizontal: Insets.i20)
                                : const GenerateWishesLayout()),
                        if (birthdayCtrl.isBirthdayGenerated == false)
                          AdCommonLayout(
                              bannerAd: birthdayCtrl.bannerAd,
                              bannerAdIsLoaded: birthdayCtrl.bannerAdIsLoaded,
                              currentAd: birthdayCtrl.currentAd),
                        if (birthdayCtrl.isLoader == true) const LoaderLayout()
                      ])))));
    });
  }
}
