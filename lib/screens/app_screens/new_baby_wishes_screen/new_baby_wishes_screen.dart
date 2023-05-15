import '../../../config.dart';

class NewBabyWishesScreen extends StatelessWidget {
  final newCtrl = Get.put(NewBabyWishesController());

  NewBabyWishesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewBabyWishesController>(builder: (_) {
      return WillPopScope(
          onWillPop: () => textToSpeechCtrl.onStopTTS(),
          child: DirectionalityRtl(
              child: Form(
                  key: newCtrl.scaffoldKey,
                  child: Scaffold(
                      backgroundColor: appCtrl.appTheme.bg1,
                      appBar: AppAppBarCommon(
                          title: appFonts.newBabyWishes,
                          leadingOnTap: () => textToSpeechCtrl.onStopTTS()),
                      body: Stack(children: [
                        SingleChildScrollView(
                            child: newCtrl.isWishGenerate == true
                                ? Column(children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          textCommon.outfitSemiBoldPrimary16(
                                              text: appFonts.lovelyGreetings),
                                          const VSpace(Sizes.s15),
                                          InputLayout(
                                              hintText: "",
                                              title: appFonts.goodWishes,
                                              color: appCtrl.appTheme.white,
                                              isMax: false,
                                              text: newCtrl.response,
                                              responseText: newCtrl.response)
                                        ]),
                                    const VSpace(Sizes.s20),
                                    ButtonCommon(
                                        title: appFonts.endBornBabyWish,
                                        onTap: () =>
                                            newCtrl.endBabyWishesSuggestion()),
                                    const VSpace(Sizes.s30),
                                    const AdCommonLayout().backgroundColor(
                                        appCtrl.appTheme.error),
                                  ]).paddingSymmetric(
                                    horizontal: Insets.i20,
                                    vertical: Insets.i30)
                                : const NewBabyWishesLayout()),
                        if (newCtrl.isLoader == true) const LoaderLayout()
                      ])))));
    });
  }
}
