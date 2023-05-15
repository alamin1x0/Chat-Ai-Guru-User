import '../../../../config.dart';

class QuickAdvisorListCommon extends StatelessWidget {
  const QuickAdvisorListCommon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuickAdvisorController>(builder: (quickAdvisorCtrl) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(appFonts.otherQuickAdvisor.tr,
                style: AppCss.outfitSemiBold16.textColor(appCtrl.appTheme.txt))
            .paddingOnly(bottom: Insets.i15),
        GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: quickAdvisorCtrl.quickAdvisorLists.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20,
                childAspectRatio: 1,
                mainAxisSpacing: 15,
                mainAxisExtent: 105,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return QuickAdvisorLayout(
                  index: index,
                  isFavorite: false,
                  selectIndex: quickAdvisorCtrl.selectedIndex,
                  data: quickAdvisorCtrl.quickAdvisorLists[index],
                  onTap: () => quickAdvisorCtrl.onTapAddFavorite(index));
            })
      ]);
    });
  }
}
