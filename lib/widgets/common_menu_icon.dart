import '../config.dart';

class CommonMenuIcon extends StatelessWidget {
  const CommonMenuIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(eSvgAssets.menu)
        .paddingSymmetric(horizontal: Insets.i20);
  }
}
