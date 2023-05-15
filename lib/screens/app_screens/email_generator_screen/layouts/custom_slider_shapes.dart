import '../../../../config.dart';

class SfTickShapes extends SfTickShape {
  @override
  void paint(PaintingContext context, Offset offset, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
        required SfSliderThemeData themeData,
        SfRangeValues? currentValues,
        dynamic currentValue,
        required Animation<double> enableAnimation,
        required TextDirection textDirection}) {
    const Size tickSize = Size(3, 15);
    // Apply active and inactive tick color based on the thumb position.
    final bool isTickRightOfThumb = offset.dx > thumbCenter!.dx;
    // The ticks positioned before the thumb position is set to activeTickColor
    // and the tick positioned after the thumb position is set to
    // inactiveTickColor.
    final Color color = isTickRightOfThumb
        ? appCtrl.appTheme.textField
        : appCtrl.appTheme.primary;
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = tickSize.width
      ..color = color;
    context.canvas.drawLine(
        Offset(offset.dx, offset.dy - themeData.activeTrackHeight - tickSize.height),
        Offset(offset.dx, offset.dy + tickSize.height),
        paint);
  }
}

class SfMinorTickShapes extends SfTickShape {
  int count = -1;
  @override
  void paint(PaintingContext context, Offset offset, Offset? thumbCenter,
      Offset? startThumbCenter, Offset? endThumbCenter,
      {required RenderBox parentBox,
        required SfSliderThemeData themeData,
        SfRangeValues? currentValues,
        dynamic currentValue,
        required Animation<double> enableAnimation,
        required TextDirection textDirection}) {
    count++;
    // Every fourth minor tick will be drawn larger, while the remaining three
    // minor ticks will be drawn smaller. This pattern will be followed until
    // the value of minorTicksPerInterval property. This count field is used
    // to identify every fourth minor tick.
    if (count > 3) {
      count = 0;
    }
    const Size minorTickSize = Size(1.5, 8);
    final bool isMinorTickRightOfThumb = offset.dx > thumbCenter!.dx;
    // The minor ticks positioned before the thumb position is set to
    // activeTickColor and the minor ticks positioned after the thumb position
    // is set to inactiveTickColor.
    final Color color = isMinorTickRightOfThumb
        ? appCtrl.appTheme.textField
        : appCtrl.appTheme.primary;

    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = minorTickSize.width
      ..color = color;

    double offsetStartY = offset.dy - minorTickSize.height - themeData.activeTrackHeight;
    double offsetEndY = offset.dy + minorTickSize.height;
    context.canvas.drawLine(
        Offset(offset.dx,  offsetStartY),
        Offset(offset.dx,  offsetEndY),
        paint);
  }
}

class SfThumbShapes extends SfThumbShape {
  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
        required RenderBox? child,
        required SfSliderThemeData themeData,
        SfRangeValues? currentValues,
        dynamic currentValue,
        required Paint? paint,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required SfThumb? thumb}) {
    const Size thumbSize = Size(2, 0);
    Paint paint = Paint()
      ..color = themeData.activeTrackColor!
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;
    context.canvas.drawLine(
        Offset(center.dx, center.dy - thumbSize.height),
        Offset(center.dx, center.dy + thumbSize.height),
        paint);
  }
}

