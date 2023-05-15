import '../config.dart';

class ApiNotesLayout extends StatelessWidget {
  final String? title;
  const ApiNotesLayout({Key? key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SvgPicture.asset(eSvgAssets.apiArrow),
      const HSpace(Sizes.s12),
      Expanded(
          child: SizedBox(
              child: Text(title!.toString().tr,
                  style: AppCss.outfitMedium14
                      .textColor(appCtrl.appTheme.txt)
                      .textHeight(1.3))))
    ]);
  }
}
