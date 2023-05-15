
import '../../../config.dart';

class ImageScannerScreen extends StatelessWidget {
  final imageCtrl = Get.put(ImageScannerController());
  ImageScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageScannerController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          resizeToAvoidBottomInset: false,
          drawer: const CommonDrawer(),
          key: imageCtrl.scaffoldKey,
          appBar: AppBar(
              backgroundColor: appCtrl.appTheme.primary,
              elevation: 0,
              toolbarHeight: 70,
              leadingWidth: Sizes.s70,
              actions: [

                const CommonBalance().marginOnly(right: Insets.i20,top: Insets.i10,bottom: Insets.i10)
              ],
              leading: const CommonMenuIcon().inkWell(
                  onTap: () =>
                      imageCtrl.scaffoldKey.currentState!.openDrawer()),
              automaticallyImplyLeading: false,
              title: Text(appFonts.imageScanner.tr,
                  style: AppCss.outfitSemiBold22
                      .textColor(appCtrl.appTheme.sameWhite))),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(appFonts.selectOneOfThe.tr,
                style:
                    AppCss.outfitMedium16.textColor(appCtrl.appTheme.primary)),
            const VSpace(Sizes.s15),
            Column(
                    children: imageCtrl.imageScannerList
                        .asMap()
                        .entries
                        .map(
                          (e) => SocialMediaListLayout(
                              data: e.value,
                              index: e.key,
                              totalLength:
                                  imageCtrl.imageScannerList.length - 1,
                              onTap: () => imageCtrl.onScanFrom(
                                  e.key.toString(), context)),
                        )
                        .toList())
                .paddingSymmetric(horizontal: Insets.i15, vertical: Insets.i20)
                .authBoxExtension(),
            const VSpace(Sizes.s10),
            Text(appFonts.byScanningAnImage.tr,textAlign: TextAlign.center,style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.lightText).textHeight(1.3))
            /*imageCtrl.image(context)*/  
          ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20));
    });
  }
}
