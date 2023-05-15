import '../config.dart';

class OrLayout extends StatelessWidget {
  const OrLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Sizes.s90,
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          const Expanded(child: Divider(height: 1, thickness: 2)),
          Text(appFonts.or.tr,
                  style: AppCss.outfitMedium14
                      .textColor(appCtrl.appTheme.lightText))
              .paddingSymmetric(horizontal: Insets.i5),
          const Expanded(child: Divider(height: 1, thickness: 2))
        ])).paddingSymmetric(vertical: Insets.i20);
  }
}
