import '../../../../config.dart';

class PageViewCommon extends StatelessWidget {
  final dynamic data;
  final GestureTapCallback? onTap;
  final String? title, description;

  const PageViewCommon(
      {Key? key, this.onTap, this.data, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingController>(builder: (onBoardingCtrl) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(alignment: Alignment.topRight, children: [
              SizedBox(
                      height: MediaQuery.of(context).size.height < 534
                          ? MediaQuery.of(context).size.height * 0.3
                          : MediaQuery.of(context).size.height * 0.58,
                      width: MediaQuery.of(context).size.height < 534
                          ? MediaQuery.of(context).size.height * 0.3
                          : MediaQuery.of(context).size.height * 0.58,
                      child: Image.network(data, fit: BoxFit.cover))
                  .paddingOnly(top: Insets.i45),
              const LanguageDropDownLayout()
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                    onBoardingCtrl.onBoardingLists.length,
                    (index) => InkWell(
                        onTap: () {
                          onBoardingCtrl.pageCtrl.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        child: const SizedBox(
                                height: Sizes.s5, width: Sizes.s22)
                            .decorated(
                                color: onBoardingCtrl.selectIndex >= index
                                    ? appCtrl.appTheme.primary
                                    : appCtrl.appTheme.primary.withOpacity(0.2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(AppRadius.r10)))
                            .paddingSymmetric(horizontal: Insets.i3)))),
            const VSpace(Sizes.s10),
            OnBoardBottomLayout(
                title: title, description: description, onTap: onTap)
          ]);
    });
  }
}
