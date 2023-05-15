

import '../../../config.dart';

class SplashScreen extends StatelessWidget {
  final splashCtrl = Get.put(SplashController());

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (_) {
      return StreamBuilder(
          stream: FirebaseFirestore.instance.collection("config").snapshots(),
          builder: (context, snapShot) {
            return Scaffold(
                body: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.asset(eImageAssets.splashBg))
                    .decorated(
                        gradient: RadialGradient(
                            focalRadius: 2,
                            radius: 2,
                            colors: [
                              appCtrl.appTheme.primary.withOpacity(0.5),
                              appCtrl.appTheme.primary
                            ],
                            center: const Alignment(-0.1, 0.1))),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    snapShot.hasData
                        ? Image.network(
                            snapShot.data!.docs[0].data()["splashLogo"],
                            height: 100,
                            width: 100)
                        : Image.asset(eImageAssets.logo,
                            height: 100, width: 100),
                    Text(appFonts.proBot,
                        style: AppCss.londrinaMedium70
                            .textColor(appCtrl.appTheme.sameWhite))
                  ],
                )
              ],
            ));
          });
    });
  }
}
