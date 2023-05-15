import '../../../../config.dart';

class TabCommon extends StatelessWidget {
  final int? index;
  final String? title, sImage, usImage;

  const TabCommon({Key? key, this.title, this.index, this.sImage, this.usImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (dashboardCtrl) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 2,
              color: dashboardCtrl.selectedIndex == index
                  ? appCtrl.appTheme.primary
                  : appCtrl.appTheme.boxBg,
              width: MediaQuery.of(context).size.width * .1,
            ),
            Column(children: [
              SvgPicture.asset(
                  dashboardCtrl.selectedIndex == index ? sImage! : usImage!,
                  height: Sizes.s20,
                  width: Sizes.s20,
                  fit: BoxFit.fill),
              const VSpace(Sizes.s5),
              Text(title!.toString().tr,
                  style: dashboardCtrl.selectedIndex == index
                      ? AppCss.outfitRegular14
                          .textColor(appCtrl.appTheme.primary)
                      : AppCss.outfitRegular13
                          .textColor(appCtrl.appTheme.lightText))
            ])
          ]).inkWell(onTap: () => dashboardCtrl.onBottomTap(index));
    });
  }
}
