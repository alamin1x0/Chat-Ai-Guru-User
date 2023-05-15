import '../../../../config.dart';

class HomeTopLayout extends StatelessWidget {
  final GestureTapCallback? onTap;

  const HomeTopLayout({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: Insets.i80),
            decoration: BoxDecoration(
                gradient: RadialGradient(
                    focalRadius: 1,
                    radius: 1,
                    center: const Alignment(-0.1, 0.1),
                    colors: [
                  appCtrl.appTheme.primary,
                  appCtrl.appTheme.radialGradient
                ])),
            child: Image.asset(eImageAssets.homeAppBar, height: Sizes.s170)
                .paddingSymmetric(
                    vertical: Insets.i20, horizontal: Insets.i35)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CommonMenuIcon().inkWell(onTap: onTap),
                CachedNetworkImage(
                    imageUrl: appCtrl.firebaseConfigModel!.homeLogo.toString(),
                    width: Sizes.s106,
                    imageBuilder: (context, imageProvider) => SizedBox(
                        width: Sizes.s106,
                        child: Column(children: [
                          Image.network(
                              appCtrl.firebaseConfigModel!.homeLogo.toString(),
                              width: Sizes.s106,
                              fit: BoxFit.fill)
                        ])),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.asset(eImageAssets.logo1, width: Sizes.s106))
              ],
            ),
            const CommonBalance().marginSymmetric(horizontal: Insets.i20)
          ],
        ).paddingSymmetric(vertical: Insets.i50)
      ],
    );
  }
}
