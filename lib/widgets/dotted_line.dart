import '../config.dart';


class DottedLines extends StatelessWidget {
  final Color? color;
  final double? width;
  const DottedLines({Key? key,this.color,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedLine(
        direction: Axis.horizontal,
        lineLength: width ?? double.infinity,
        lineThickness: 1,
        dashLength: 3,
        dashColor:color ?? appCtrl.appTheme.lightText);
  }
}
