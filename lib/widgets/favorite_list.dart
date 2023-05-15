import '../config.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeCtrl) {
        return GridView.builder(
            padding: EdgeInsets.zero,
            physics:
            const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: homeCtrl.quickAdvisorCtrl
                .favoriteDataList.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20,
                childAspectRatio: 1,
                mainAxisSpacing: 15,
                mainAxisExtent: 105,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return QuickAdvisorLayout(
                  index: index,
                  isFavorite: true,
                  selectIndex: homeCtrl
                      .quickAdvisorCtrl
                      .selectedIndexRemove,
                  data: homeCtrl.quickAdvisorCtrl
                      .favoriteDataList[index],
                  onTap: () => homeCtrl
                      .quickAdvisorCtrl
                      .onTapRemoveFavorite(
                      index));
            });
      }
    );
  }
}
