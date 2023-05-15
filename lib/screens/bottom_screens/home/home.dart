import 'package:probot/config.dart';

class Home extends StatelessWidget {
  final homeCtrl = Get.put(HomeController());

  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      appCtrl.commonThemeChange();
      return CommonStream(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: homeCtrl.scaffoldKey,
              drawer: const CommonDrawer(),
              body: Stack(alignment: Alignment.bottomCenter, children: [
                Column(children: [
                  HomeTopLayout(
                      onTap: () =>
                          homeCtrl.scaffoldKey.currentState!.openDrawer()),
                  const DottedLines(),
                   
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                        const QuickViewAllLayout(),
                        StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("categoryAccess")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                appCtrl.categoryAccessModel =
                                    CategoryAccessModel.fromJson(
                                        snapshot.data!.docs[0].data());
                                appCtrl.storage.write(session.categoryConfig,
                                    appCtrl.categoryAccessModel);
                                homeCtrl.getQuickData();
                                homeCtrl.getFavData();
                                return GetBuilder<QuickAdvisorController>(
                                    builder: (quickCtrl) {
                                  return quickCtrl.favoriteDataList.isNotEmpty
                                      ? const FavoriteList()
                                      : const HomeQuickAdviceList();
                                });
                              } else {
                                return Container();
                              }
                            }),
                        const VSpace(Sizes.s70)
                      ]).marginSymmetric(horizontal: Sizes.s20)))
                ]),
                AdCommonLayout(
                    bannerAdIsLoaded: homeCtrl.bannerAdIsLoaded,
                    bannerAd: homeCtrl.bannerAd,
                    currentAd: homeCtrl.currentAd)
              ]),
              backgroundColor: appCtrl.appTheme.bg1));
    });
  }
}
