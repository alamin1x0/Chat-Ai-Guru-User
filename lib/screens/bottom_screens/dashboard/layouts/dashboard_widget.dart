import '../../../../../../config.dart';
import 'material_indicator.dart';

class DashboardWidget{

  //indicator
  MaterialIndicator materialIndicator() =>  MaterialIndicator(
      height: 2,

      color: appCtrl.appTheme.primary,
      horizontalPadding: Insets.i25,
      topLeftRadius: 0,
      topRightRadius: 0,
      bottomLeftRadius: 0,
      bottomRightRadius: 0,
      tabPosition: TabPosition.top);

  //tab border layout
  Widget tabBorderLayout({Widget? child}) => Container(
    height: Sizes.s58,
    decoration: BoxDecoration(
      color: appCtrl.appTheme.white,
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(53, 193, 255, 0.08),
          blurRadius: 20,offset: Offset(4,-1)
        )
      ],
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(AppRadius.r10),topRight: Radius.circular(AppRadius.r10)),
    ),
    child: child,
  );
}