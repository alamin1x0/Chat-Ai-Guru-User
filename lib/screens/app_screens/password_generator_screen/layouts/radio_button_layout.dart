import '../../../../config.dart';

class PasswordRadioButtonLayout extends StatelessWidget {
  final int? selectIndex, index;
  final String? data;
  final GestureTapCallback? onTap;

  const PasswordRadioButtonLayout(
      {Key? key, this.index, this.selectIndex, this.data, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          padding: const EdgeInsets.all(Insets.i3),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: selectIndex == index
                      ? appCtrl.appTheme.primary
                      : appCtrl.appTheme.lightText)),
          child: Icon(Icons.circle,
              size: 10,
              color: selectIndex == index
                  ? appCtrl.appTheme.primary
                  : appCtrl.appTheme.trans)),
      const HSpace(Sizes.s10),
      Text(data.toString().tr,
          style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt))
    ]).inkWell(onTap: onTap).paddingOnly(bottom: Insets.i15);
  }
}
