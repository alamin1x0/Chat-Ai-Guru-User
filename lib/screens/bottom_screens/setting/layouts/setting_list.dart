import '../../../../config.dart';

class SettingList extends StatelessWidget {
  final dynamic data;
  final int? index;

  const SettingList({Key? key, this.data, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (settingCtrl) {
      return Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          UserLayout(data: data),
          Row(children: [
            if (data["title"] == "language")
              Text(
                      appCtrl.languageVal == "en"
                          ? "english".tr
                          : appCtrl.languageVal == "fr"
                              ? "french".tr
                              : appCtrl.languageVal == "ge"
                                  ? "germane".tr
                                  : appCtrl.languageVal == "hi"
                                      ? "hindi".tr
                                      : appCtrl.languageVal == "it"
                                          ? "italian".tr
                                          : appCtrl.languageVal == "ja"
                                              ? "japanise".tr
                                              : "arabic",
                      style: AppCss.outfitMedium14
                          .textColor(appCtrl.appTheme.lightText))
                  .marginSymmetric(horizontal: Insets.i15),
            (data["title"] == "rtl")
                ? CommonSwitcher(index: index)
                : data["title"] != "logout"
                    ? SvgPicture.asset(
                        appCtrl.isRTL || appCtrl.languageVal == "ar"
                            ? eSvgAssets.leftArrow
                            : eSvgAssets.arrowRight1,
                        colorFilter: ColorFilter.mode(
                            appCtrl.appTheme.txt, BlendMode.srcIn))
                    : Container()
          ])
        ]).paddingSymmetric(horizontal: Insets.i15),
        if (data["title"] != "logout")
          DottedLine(
                  direction: Axis.horizontal,
                  lineLength: double.infinity,
                  lineThickness: 1,
                  dashLength: 3,
                  dashColor: appCtrl.isTheme
                      ? const Color.fromRGBO(255, 255, 255, 0.1)
                      : appCtrl.appTheme.greyLight)
              .marginSymmetric(vertical: Insets.i15)
      ]).inkWell(onTap: () => settingCtrl.onSettingTap(data));
    });
  }
}
