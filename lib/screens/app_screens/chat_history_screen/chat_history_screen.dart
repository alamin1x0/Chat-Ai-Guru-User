import '../../../config.dart';

class ChatHistoryScreen extends StatelessWidget {
  final chatHistoryCtrl = Get.put(ChatHistoryController());

  ChatHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatHistoryController>(builder: (_) {
      return Scaffold(
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: ChatHistoryAppBar(
              index: chatHistoryCtrl.selectedIndex,
              onDeleteTap: () => chatHistoryCtrl.onTapDeleteHistory()),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("chats")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container();
                } else if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(appCtrl.appTheme.primary),
                  )).height(MediaQuery.of(context).size.height);
                } else {
                  return snapshot.data!.docs.isEmpty
                      ? Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Image.asset(eImageAssets.notification,
                                  height: Sizes.s180),
                              const VSpace(Sizes.s20),
                              Text(appFonts.noDataFound.tr,
                                  textAlign: TextAlign.center,
                                  style: AppCss.outfitMedium14
                                      .textColor(appCtrl.appTheme.lightText))
                            ])).height(MediaQuery.of(context).size.height)
                      : SingleChildScrollView(
                          child: Column(children: [
                          ...snapshot.data!.docs
                              .asMap()
                              .entries
                              .map((e) => ChatHistoryLayout(
                                  id: e.value.id,
                                  data: e.value.data(),
                                  isLongPress: chatHistoryCtrl.isLongPress,
                                  onLongPressTap: () => chatHistoryCtrl
                                      .onLogPressChat(e.value.id),
                                  onTap: () => chatHistoryCtrl.onTapChat(
                                      e.value.id, e.value.data())))
                              .toList()
                        ]).paddingSymmetric(
                              vertical: Insets.i25, horizontal: Insets.i20));
                }
              }));
    });
  }
}
