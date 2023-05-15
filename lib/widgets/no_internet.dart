

import '../config.dart';

class NoInternet extends StatelessWidget {
  final ConnectivityResult? connectionStatus;

  const NoInternet({Key? key, this.connectionStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {

          return snapshot.data == ConnectivityResult.none ||
                  snapshot.data == null
              ? Scaffold(

                  backgroundColor: appCtrl.appTheme.white,
                  body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                          Image.asset(eImageAssets.wires),
                          const VSpace(Sizes.s10),
                          Image.asset(eImageAssets.noInternet,height: Sizes.s200,width: Sizes.s200,fit: BoxFit.contain),
                          const VSpace(Sizes.s15),
                          Text(
                            appFonts.noInternet.tr,
                            style:
                                AppCss.outfitBold24.textColor(appCtrl.appTheme.txt),
                          ),
                          const VSpace(Sizes.s10),
                          Text(
                          appFonts.noInternetDesc.tr,
                              textAlign: TextAlign.center,
                              style: AppCss.outfitLight14
                                  .textColor(appCtrl.appTheme.lightText))
                    ],
                  ),
                          ButtonCommon(title: appFonts.retry,margin: Insets.i20,onTap: (){
                            if(snapshot.data != ConnectivityResult.none || snapshot.data != null){
                              final splashCtrl = Get.find<SplashController>();
                              splashCtrl.onReady();
                            }
                          }),
                        ],
                      )),
                )
              : SplashScreen();
        });
  }
}
