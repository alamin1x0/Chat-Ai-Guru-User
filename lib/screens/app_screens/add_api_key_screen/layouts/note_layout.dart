import '../../../../config.dart';

class NoteLayout extends StatelessWidget {
  const NoteLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddApiKeyController>(builder: (apiCtrl) {
      return Column(
          children: apiCtrl.apiNoteLists
              .asMap()
              .entries
              .map((e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(e.value["title"].toString().tr,
                        style: AppCss.outfitMedium16
                            .textColor(appCtrl.appTheme.primary)),
                    const VSpace(Sizes.s15),
                    ...e.value["note"]
                        .asMap()
                        .entries
                        .map((s) =>
                            ApiNotesLayout(title: s.value["title"].toString().tr)
                                .paddingOnly(bottom: Insets.i25))
                        .toList()
                  ]).paddingSymmetric(horizontal: Insets.i15))
              .toList()).paddingSymmetric(
          horizontal: Insets.i15);
    });
  }
}

