import '../../../../config.dart';

class BackgroundList extends StatelessWidget {
  const BackgroundList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return Scaffold(
        backgroundColor: appCtrl.appTheme.white,
        appBar: AppAppBarCommon(
            title: "Default Wallpaper",isAction: false,leadingOnTap: ()=> Get.back()),
        body: GridView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(Insets.i20),
          itemCount: chatCtrl.backgroundList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 20,
              mainAxisExtent: 216,
              mainAxisSpacing: 20.0,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Image.asset(
              appCtrl.isUserThemeChange ? appCtrl.isUserTheme ? chatCtrl.backgroundList[index]["darkImage"] : chatCtrl.backgroundList[index]["image"] :  appCtrl.isTheme ? chatCtrl.backgroundList[index]["darkImage"] : chatCtrl.backgroundList[index]["image"],
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
              height: Sizes.s216,
            ).clipRRect(all: AppRadius.r10).inkWell(onTap: ()=> Get.back(result: chatCtrl.backgroundList[index]));
          },
        ),
      );
    });
  }
}
