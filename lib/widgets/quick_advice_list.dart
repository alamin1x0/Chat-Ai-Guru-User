import '../config.dart';

class HomeQuickAdviceList extends StatelessWidget {
  const HomeQuickAdviceList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeCtrl) {
        return GridView.builder(
            padding: EdgeInsets.zero,
            physics:
            const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
            homeCtrl.quickAdvisorLists.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20,
                childAspectRatio: 1,
                mainAxisSpacing: 15,
                mainAxisExtent: 105,
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return QuickAdvisorLayout(
                  data: homeCtrl
                      .quickAdvisorLists[index]);
            });
      }
    );
  }
}
