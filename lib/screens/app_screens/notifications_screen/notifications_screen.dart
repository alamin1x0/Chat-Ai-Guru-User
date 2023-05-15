import '../../../config.dart';

class NotificationsScreen extends StatelessWidget {
  final notificationCtrl = Get.put(NotificationsController());

  NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
              title: appFonts.notification,
              actionIcon: eSvgAssets.delete,
              leadingOnTap: () => Get.back()),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(children: [
                  Image.asset(eImageAssets.notification, height: Sizes.s180),
                  const VSpace(Sizes.s20),
                  Text(appFonts.youDontHave,
                      textAlign: TextAlign.center,
                      style: AppCss.outfitMedium14
                          .textColor(appCtrl.appTheme.lightText))
                ]),
                ButtonCommon(title: appFonts.refresh)
              ]).paddingSymmetric(
              horizontal: Insets.i20,
              vertical: Insets
                  .i40) /*SingleChildScrollView(
            child: SizedBox(
              child: Column(
                children: notificationCtrl.notificationLists.asMap().entries.map((e) => NotificationLayout(data: e.value)).toList()
              ).paddingSymmetric(horizontal: Insets.i20,vertical: Insets.i25),
            ).alignment(Alignment.center),
          ),*/
          );
    });
  }
}
