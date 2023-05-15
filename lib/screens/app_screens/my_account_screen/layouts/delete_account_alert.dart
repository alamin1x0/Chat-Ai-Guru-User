

import '../../../../config.dart';

class DeleteAlert extends StatelessWidget {

  const DeleteAlert({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAccountController>(builder: (chatCtrl) {
      return AlertDialog(
        backgroundColor: appCtrl.appTheme.white,
        title:  Text(appFonts.alert.tr,style: AppCss.outfitblack16.textColor(appCtrl.appTheme.txt)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[
            Text(appFonts.deleteConfirmation.tr,style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt)),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child:  Text(appFonts.no.tr,style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt)),
          ),
          TextButton(
            onPressed: () => chatCtrl.deleteAccount(),
            child:  Text(appFonts.yes.tr,style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.txt),),
          ),
        ],
      );
    });
  }
}
