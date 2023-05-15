import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:probot/config.dart';

class ChatLayout extends StatelessWidget {
  final chatCtrl = Get.put(ChatLayoutController());

  ChatLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("SE : ${chatCtrl.selectedImage}");
    return GetBuilder<ChatLayoutController>(builder: (_) {
      return CommonStream(child: GetBuilder<AppController>(builder: (appCtrl) {
        return DirectionalityRtl(
            child: WillPopScope(
                onWillPop: () async {
                  chatCtrl.speechStopMethod();
                  chatCtrl.clearData();
                  return true;
                },
                child: Screenshot(
                    controller: chatCtrl.screenshotController,
                    child: Scaffold(
                        resizeToAvoidBottomInset: true,
                        key: chatCtrl.scaffoldKey,
                        drawer: const CommonDrawer(),
                        backgroundColor: appCtrl.appTheme.bg1,
                        appBar: const ChatScreenAppBar(),
                        body: InkWell(
                            onTap: () {
                              chatCtrl.isLongPress = false;
                              chatCtrl.selectedData = [];
                              chatCtrl.selectedIndex = [];
                              chatCtrl.update();
                            },
                            child: NotificationListener<
                                    OverscrollIndicatorNotification>(
                                onNotification: (OverscrollIndicatorNotification
                                    overscroll) {
                                  overscroll.disallowIndicator();
                                  return true;
                                },
                                child: Column(children: [
                                  const VSpace(Sizes.s10),
                                  AdCommonLayout(
                                      bannerAd: chatCtrl.bannerAd,
                                      bannerAdIsLoaded:
                                          chatCtrl.bannerAdIsLoaded,
                                      currentAd: chatCtrl.currentAd),
                                  Text("Today, ${DateFormat("hh:mm a").format(DateTime.now())}",
                                          style: AppCss.outfitMedium14
                                              .textColor(appCtrl.appTheme.txt))
                                      .marginOnly(top: Insets.i5),
                                  const VSpace(Sizes.s13),
                                  const Expanded(flex: 5, child: ChatList()),
                                  Container(),
                                  const Expanded(flex: 0, child: ChatTextBox())
                                ]).chatBgExtension(
                                    chatCtrl.selectedImage)))))));
      }));
    });
  }
}
