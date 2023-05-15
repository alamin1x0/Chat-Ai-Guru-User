import '../../../../config.dart';

class LanguageDropDownLayout extends StatelessWidget {
  const LanguageDropDownLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (onBoardingCtrl) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
            width: Sizes.s106,
            child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                    child: DropdownButton(
                        value: onBoardingCtrl.langValue,
                        borderRadius: const BorderRadius.all(
                            Radius.circular(AppRadius.r8)),
                        style: AppCss.outfitSemiBold16
                            .textColor(appCtrl.appTheme.txt),
                        icon: SvgPicture.asset(eSvgAssets.dropDown,
                            colorFilter: ColorFilter.mode(
                                appCtrl.appTheme.txt, BlendMode.srcIn)),
                        isDense: true,
                        isExpanded: true,
                        hint: Text(appFonts.english.toString().tr),
                        items: onBoardingCtrl.selectLanguageLists
                            .asMap()
                            .entries
                            .map((e) {
                          return DropdownMenuItem(
                              value: e.value.title,
                              child: Row(children: [
                                Image.asset(e.value.image!, height: Sizes.s30),
                                const HSpace(Sizes.s6),
                                Text(e.value.title!.toString().tr,
                                        overflow: TextOverflow.ellipsis)
                                    .width(Sizes.s55)
                              ]),
                              onTap: () =>
                                  onBoardingCtrl.onLanguageSelectTap(e.value));
                        }).toList(),
                        onChanged: (val) async {
                          onBoardingCtrl.langValue = val.toString();
                          onBoardingCtrl.update();
                        }).paddingOnly(top: Insets.i50, bottom: Insets.i10)))),
        if (onBoardingCtrl.selectIndex != 2)
          Text(appFonts.skip.tr,
                  style: AppCss.outfitMedium16
                      .textColor(appCtrl.appTheme.lightText))
              .inkWell(onTap: () {
            appCtrl.isOnboard = true;
            appCtrl.storage.write("isOnboard", appCtrl.isOnboard);
            appCtrl.update();
            Get.toNamed(routeName.allowNotificationScreen);
          }).paddingOnly(top: Insets.i50, bottom: Insets.i10)
      ]).paddingSymmetric(horizontal: Insets.i20);
    });
  }
}
