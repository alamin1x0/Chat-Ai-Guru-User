import '../../../../config.dart';

class SuggestionList extends StatelessWidget {
  const SuggestionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatLayoutController>(builder: (chatCtrl) {
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("categorySuggestion")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                  child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(appFonts.questionSuggestion.tr,
                              style: AppCss.outfitSemiBold20
                                  .textColor(appCtrl.appTheme.txt)),
                          SvgPicture.asset(eSvgAssets.cross)
                              .inkWell(onTap: () => Get.back())
                        ]),
                    const DottedLines().paddingSymmetric(vertical: Insets.i20),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: snapshot.data!.docs
                                .asMap()
                                .entries
                                .map((e) => SuggestionLayout(
                                    data: e.value,
                                    selectIndex: chatCtrl.selectIndex,
                                    index: e.key,
                                    onTap: () {
                                      chatCtrl.selectIndex = e.key;
                                      chatCtrl.update();
                                    }))
                                .toList())),
                    const VSpace(Sizes.s20),
                    Text(appFonts.preBuildQuestions,
                        style: AppCss.outfitMedium16
                            .textColor(appCtrl.appTheme.txt)),
                    const VSpace(Sizes.s15),
                    ...snapshot.data!.docs[chatCtrl.selectIndex]
                        .data()["suggestionList"]
                        .asMap()
                        .entries
                        .map((e) => PreBuildQuestionsLayout(
                            data: e.value,
                            onTap: () {
                              chatCtrl.chatController.text = e.value;
                              chatCtrl.update();
                              Get.back();
                            }))
                        .toList()
                  ]))).paddingSymmetric(
                  horizontal: Insets.i20, vertical: Insets.i20);
            } else {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                const CircularProgressIndicator().paddingAll(Insets.i20)
              ]);
            }
          });
    });
  }
}
