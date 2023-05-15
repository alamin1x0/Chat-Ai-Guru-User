import '../../../../config.dart';

class CaptionToneLayout extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTap;
  final int? index, selectedIndex;

  const CaptionToneLayout(
      {Key? key, this.data, this.onTap, this.index, this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(alignment: Alignment.center, children: [
        SizedBox(
                child: Image.asset(data["image"], height: Sizes.s44)
                    .paddingAll(Insets.i10))
            .decorated(
                color: appCtrl.appTheme.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: appCtrl.appTheme.primaryLight,
                      blurRadius: 2,
                      spreadRadius: 2)
                ],
                border:
                    Border.all(color: appCtrl.appTheme.primaryLight, width: 2)),
        if (index == selectedIndex)
          DottedBorder(
              borderType: BorderType.RRect,
              color: appCtrl.appTheme.primary,
              radius: const Radius.circular(AppRadius.r50),
              child: SizedBox(
                      child: Icon(Icons.check_circle_sharp,
                              color: appCtrl.appTheme.white, size: Sizes.s25)
                          .paddingAll(Insets.i15))
                  .decorated(
                      color: appCtrl.appTheme.txt.withOpacity(0.7),
                      shape: BoxShape.circle))
      ]),
      const VSpace(Sizes.s10),
      Text(data["title"].toString().tr,
          style: AppCss.outfitSemiBold14.textColor(index == selectedIndex
              ? appCtrl.appTheme.primary
              : appCtrl.appTheme.txt))
    ]).inkWell(onTap: onTap);
  }
}
