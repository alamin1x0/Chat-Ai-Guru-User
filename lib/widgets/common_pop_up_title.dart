import '../config.dart';

class CommonPopUpTitle extends StatelessWidget {
  final String? title;
  const CommonPopUpTitle({Key? key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title!.tr,
            style: AppCss.outfitblack20
                .textColor(appCtrl.appTheme.txt)
                .textDecoration(TextDecoration.none)),
        InkWell(
            onTap: () => Get.back(),
            child: SvgPicture.asset(
              eSvgAssets.cancel,
              height: Sizes.s24
            ))
      ],
    ).paddingAll(Insets.i20);
  }
}
