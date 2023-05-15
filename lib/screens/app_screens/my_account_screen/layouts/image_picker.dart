import '../../../../config.dart';
import 'icon_creation.dart';

class ImagePickerLayout extends StatelessWidget {
  final GestureTapCallback? cameraTap, galleryTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: Sizes.s150,
      color: appCtrl.appTheme.white,
      alignment: Alignment.bottomCenter,
      child: Column(children: [
        const VSpace(Sizes.s20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconCreation(
                icons: Icons.camera,
                color: appCtrl.isUserThemeChange
                    ? appCtrl.isUserTheme
                        ? appCtrl.appTheme.white
                        : appCtrl.appTheme.primary
                    : appCtrl.isTheme
                        ? appCtrl.appTheme.white
                        : appCtrl.appTheme.primary,
                text: appFonts.camera.tr,
                onTap: cameraTap),
            IconCreation(
                icons: Icons.image,
                color: appCtrl.isUserThemeChange
                    ? appCtrl.isUserTheme
                        ? appCtrl.appTheme.white
                        : appCtrl.appTheme.primary
                    : appCtrl.isTheme
                        ? appCtrl.appTheme.white
                        : appCtrl.appTheme.primary,
                text: appFonts.gallery.tr,
                onTap: galleryTap),
          ],
        ),
      ]),
    );
  }

  const ImagePickerLayout({Key? key, this.cameraTap, this.galleryTap})
      : super(key: key);
}
