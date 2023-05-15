import '../../../../config.dart';

class UserImage extends StatelessWidget {
  final String? name, image;
  final bool? isLoading;

  const UserImage({Key? key, this.name, this.image, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomRight, children: [
      isLoading!
          ? CircularProgressIndicator(color: appCtrl.appTheme.sameWhite)
              .paddingAll(Insets.i40)
              .decorated(
                  shape: BoxShape.circle, color: appCtrl.appTheme.primary)
          : image != null
              ? Container(
                  margin: const EdgeInsets.only(top: Insets.i10),
                  height: Sizes.s110,
                  width: Sizes.s110,
                  decoration: BoxDecoration(
                      color: appCtrl.appTheme.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: appCtrl.appTheme.bg.withOpacity(.6),
                            blurRadius: 3)
                      ],
                      image: DecorationImage(
                          fit: BoxFit.fill, image: NetworkImage(image!))))
              : Text(name != null ? name![0] : "S",
                      style: AppCss.outfitExtraBold40
                          .textColor(appCtrl.appTheme.sameWhite))
                  .paddingAll(Insets.i40)
                  .decorated(
                      shape: BoxShape.circle, color: appCtrl.appTheme.primary),
      SvgPicture.asset(eSvgAssets.camera, fit: BoxFit.scaleDown)
          .paddingAll(Insets.i8)
          .decorated(
              shape: BoxShape.circle,
              color: appCtrl.appTheme.sameWhite,
              border: Border.all(
                  width: 2, color: appCtrl.appTheme.primary.withOpacity(0.1)))
          .paddingOnly(bottom: Insets.i8)
    ]);
  }
}
