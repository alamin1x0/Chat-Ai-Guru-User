import '../../../config.dart';

class SelectCharacterScreen extends StatelessWidget {
  final selectCharacterCtrl = Get.put(SelectCharacterController());

  SelectCharacterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectCharacterController>(builder: (_) {
      return Scaffold(
          appBar: const AppBarCommon(isSystemNavigate: true),
          body: Container(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                            width: double.infinity,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(appFonts.selectCharacter.tr,
                                      style: AppCss.outfitSemiBold22
                                          .textColor(appCtrl.appTheme.txt)),
                                  const VSpace(Sizes.s10),
                                  Text(appFonts.youCanChangeIt.tr,
                                      style: AppCss.outfitMedium16.textColor(
                                          appCtrl.appTheme.lightText)),
                                  const DottedLines()
                                      .paddingOnly(top: Insets.i20),
                                  const VSpace(Sizes.s20),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("characters")
                                          .where("isActive", isEqualTo: true)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return GridView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisSpacing: 15,
                                                      mainAxisExtent: 110,
                                                      mainAxisSpacing: 10,
                                                      crossAxisCount: 3),
                                              itemBuilder: (context, index) {
                                                return CharacterLayout(
                                                    onTap: () =>
                                                        selectCharacterCtrl
                                                            .onCharacterChange(
                                                                index,
                                                                snapshot.data!
                                                                    .docs[index]
                                                                    .data()),
                                                    selectIndex:
                                                        appCtrl.characterIndex,
                                                    index: index,
                                                    data: snapshot
                                                        .data!.docs[index]
                                                        .data());
                                              });
                                        } else {
                                          return Container();
                                        }
                                      })
                                ]).paddingSymmetric(
                                horizontal: Insets.i20, vertical: Insets.i25))
                        .authBoxExtension(),
                    ButtonCommon(
                        title: appFonts.continues,
                        onTap: () => selectCharacterCtrl.onContinue())
                  ]).paddingSymmetric(
                  horizontal: Insets.i20, vertical: Insets.i15)));
    });
  }
}
