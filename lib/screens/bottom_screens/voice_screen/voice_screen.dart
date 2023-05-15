import '../../../config.dart';

class VoiceScreen extends StatelessWidget {
  final voiceCtrl = Get.put(VoiceController());

  VoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoiceController>(builder: (_) {
      return Scaffold(
          drawer: const CommonDrawer(),
          key: voiceCtrl.scaffoldKey,
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppBar(
              leadingWidth: Sizes.s70,
              leading: const CommonMenuIcon().inkWell(
                  onTap: () =>
                      voiceCtrl.scaffoldKey.currentState!.openDrawer()),
              automaticallyImplyLeading: false,
              backgroundColor: appCtrl.appTheme.primary,
              actions: [
                const CommonBalance().marginOnly(
                    right: Insets.i20, top: Insets.i10, bottom: Insets.i10)
              ],
              title: Text(appFonts.voice.tr,
                  style: AppCss.outfitExtraBold22
                      .textColor(appCtrl.appTheme.sameWhite))),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(eImageAssets.voiceImage,
                          height: Sizes.s260,
                          width: Sizes.s280,
                          alignment: Alignment.center),
                      Text(appFonts.pressTheButton.tr,
                              textAlign: TextAlign.center,
                              style: AppCss.outfitMedium14
                                  .textColor(appCtrl.appTheme.lightText)
                                  .textHeight(1.3))
                          .padding(horizontal: Insets.i40, top: Insets.i20)
                    ]),
                Column(children: [
                  Image.asset(
                          voiceCtrl.isListening.value == false
                              ? eImageAssets.voice
                              : appCtrl.isTheme
                                  ? eGifAssets.speechStart
                                  : eGifAssets.speechStartDark,
                          height: Sizes.s60)
                      .inkWell(onTap: () {
                    Vibration.vibrate(duration: 200);
                    voiceCtrl.speechToText();
                    voiceCtrl.update();
                  }).paddingSymmetric(vertical: Insets.i15)
                ])
              ]));
    });
  }
}
