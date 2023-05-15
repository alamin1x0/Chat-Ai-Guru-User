import 'dart:developer';
import 'package:flutter/services.dart';
import '../../../config.dart';

class OnBoardingScreen extends StatelessWidget {
  final onBoardingCtrl = Get.put(OnBoardingController());

  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (_) {
      return WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop();
            return true;
          },
          child: Scaffold(
              backgroundColor: appCtrl.appTheme.bg1,
              body: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("onBoardScreen")
                      .snapshots(),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      List images = snapShot.data!.docs[0].data()["images"];
                      List languages =
                          snapShot.data!.docs[0].data()["languages"];
                      log("========+++++=======${appCtrl.languageVal}");
                      int i = languages.indexWhere((element) =>
                          element["language"] == appCtrl.languageVal);
                      log("===============$i");
                      String title = languages[i]["title"];
                      String description = languages[i]["description"];
                      return PageView(
                          onPageChanged: (index) {
                            appCtrl.isOnboard = true;
                            appCtrl.storage
                                .write("isOnboard", appCtrl.isOnboard);
                            onBoardingCtrl.selectIndex = index;
                            onBoardingCtrl.update();
                          },
                          controller: onBoardingCtrl.pageCtrl,
                          children: images
                              .asMap()
                              .entries
                              .map((e) => PageViewCommon(
                                  data: e.value,
                                  title: title,
                                  description: description,
                                  onTap: () {
                                    if (onBoardingCtrl.selectIndex == 2) {
                                      Get.toNamed(
                                          routeName.allowNotificationScreen);
                                    } else {
                                      onBoardingCtrl.pageCtrl.nextPage(
                                          duration:
                                              const Duration(microseconds: 500),
                                          curve: Curves.bounceInOut);
                                      appCtrl.isOnboard = true;
                                      appCtrl.storage.write(
                                          "isOnboard", appCtrl.isOnboard);
                                    }
                                  }))
                              .toList());
                    } else {
                      return Container();
                    }
                  })));
    });
  }
}
