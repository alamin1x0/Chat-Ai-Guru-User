import 'dart:developer';

import 'package:probot/config.dart';

class DashboardController extends GetxController
    with GetTickerProviderStateMixin {
  int selectedIndex = 0;
  int lastSelectedIndex = 0;
  List bottomList = [];
  TabController? con;

  List<AnimationController>? animationControllers;
  List<Animation>? animation;
  final duration = const Duration(milliseconds: 500);
  late int iconCount = 0;
  late int selectedIndexBottom;
  late AnimationController animationController;
  late Tween<double> colorTween;
  final chatLayoutCtrl = Get.isRegistered<ChatLayoutController>()
      ? Get.find<ChatLayoutController>()
      : Get.put(ChatLayoutController());

//list of bottommost page
  List<Widget> widgetOptions = <Widget>[
    Home(),
    const Text("CHAT"),
    ImageGenerator(),
    VoiceScreen(),
    ImageScannerScreen(),
  ];

  @override
  void onReady() async {
    con = TabController(vsync: this, length: 5, initialIndex: 0)
      ..addListener(listener);
    animationControllers = List.generate(5, (i) {
      return AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 750),
          reverseDuration: const Duration(milliseconds: 350));
    });
    bottomList = appArray.bottomList;
    update();
    chatLayoutCtrl.onReady();
    chatLayoutCtrl.update();
    super.onReady();
  }

  void listener() {
    if (con!.indexIsChanging) {
      animationControllers![con!.previousIndex].reverse();
    } else {
      animationControllers![con!.index].forward();
    }
    update();
  }

  //bottom nav bar tap
  onBottomTap(val) async {
    lastSelectedIndex = selectedIndex;
    selectedIndex = val;
    con!.index = val;
    con!.addListener(listener);
    update();

    if (selectedIndex == 1) {
      if (appCtrl.firebaseConfigModel!.isAddShow!) {
        if (appCtrl.firebaseConfigModel!.isGoogleAdmobEnable!) {
          chatLayoutCtrl.showInterstitialAd();
        } else {
          log("FB");
          chatLayoutCtrl.loadInterstitialAd();
          //chatLayoutCtrl.showFbInterstitialAd();
        }
      }
      chatLayoutCtrl.getChatId();
      chatLayoutCtrl.update();
      Navigator.of(Get.context!).push(createRoute()).then((value) {
        selectedIndex = lastSelectedIndex;
        con!.index = selectedIndex;
        update();
        Get.forceAppUpdate();
      });
    } else if (selectedIndex == 2) {
      addCtrl.onInterstitialAdShow();
      update();
    }
  }

  //filter page route
  Route createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => ChatLayout(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  onSelectedIndex(index) {
    selectedIndex = index;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    con!
      ..removeListener(listener)
      ..dispose();
    for (var ac in animationControllers!) {
      ac.dispose();
    }
  }
}
