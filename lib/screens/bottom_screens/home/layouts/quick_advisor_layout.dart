import '../../../../config.dart';

class QuickAdvisorLayout extends StatelessWidget {
  final dynamic data;
  final bool isFavorite;
  final int? selectIndex, index;
  final GestureTapCallback? onTap;

  const QuickAdvisorLayout(
      {Key? key,
      this.data,
      this.selectIndex,
      this.onTap,
      this.index,
      this.isFavorite = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.centerRight, children: [
      Stack(alignment: Alignment.bottomCenter, children: [
        Stack(alignment: Alignment.topLeft, children: [
          Container(
              alignment: Alignment.bottomCenter,
              height: Sizes.s102,
              width: Sizes.s100,
              child: Image.asset(eImageAssets.quickAdvisorContainer,
                  color: appCtrl.appTheme.boxBg,
                  alignment: Alignment.bottomCenter)),
          SizedBox(
                  height: Sizes.s45,
                  width: Sizes.s45,
                  child: SvgPicture.asset(data["icon"],
                          height: Sizes.s24,
                          width: Sizes.s24,
                          fit: BoxFit.scaleDown,
                          colorFilter: ColorFilter.mode(
                              appCtrl.appTheme.sameWhite, BlendMode.srcIn))
                      .decorated(
                          color: appCtrl.appTheme.primary,
                          shape: BoxShape.circle))
              .paddingOnly(left: Insets.i10)
        ]),
        SizedBox(
            width: Sizes.s80,
            child: Text(data["title"].toString().tr,
                    textAlign: TextAlign.start,
                    style:
                        AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt))
                .padding(bottom: Insets.i10, horizontal: Insets.i5))
      ]).inkWell(onTap: () {
        if (data["title"] == appFonts.translateAnything) {
          Get.toNamed(routeName.translateScreen);
        } else if (data["title"] == appFonts.codeGenerator) {
          Get.toNamed(routeName.codeGeneratorScreen);
        } else if (data["title"] == appFonts.emailGenerator) {
          Get.toNamed(routeName.emailWriterScreen);
        } else if (data["title"] == appFonts.socialMedia) {
          Get.toNamed(routeName.socialMediaScreen);
        } else if (data["title"] == appFonts.passwordGenerator) {
          Get.toNamed(routeName.passwordGeneratorScreen);
        } else if (data["title"] == appFonts.essayWriter) {
          Get.toNamed(routeName.essayWriterScreen);
        } else if (data["title"] == appFonts.travelHangout) {
          Get.toNamed(routeName.travelScreen);
        } else if (data["title"] == appFonts.personalAdvice) {
          Get.toNamed(routeName.personalAdvisorScreen);
        } else if (data["title"] == appFonts.content1) {
          Get.toNamed(routeName.contentWriterScreen);
        } else {
          Get.toNamed(routeName.chatLayout);
          final chatCtrl = Get.isRegistered<ChatLayoutController>()
              ? Get.find<ChatLayoutController>()
              : Get.put(ChatLayoutController());
          chatCtrl.getChatId();
        }
      }),
      SvgPicture.asset(isFavorite
              ? eSvgAssets.fillStar
              : selectIndex != null
                  ? selectIndex == index
                      ? eSvgAssets.fillStar
                      : eSvgAssets.unFillStar
                  : eSvgAssets.unFillStar)
          .inkWell(onTap: onTap)
          .padding(bottom: Insets.i20, horizontal: Insets.i8)
    ]);
  }
}
