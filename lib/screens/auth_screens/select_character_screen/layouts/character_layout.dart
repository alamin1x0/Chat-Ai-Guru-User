import '../../../../config.dart';

class CharacterLayout extends StatelessWidget {
  final dynamic data;
  final int? selectIndex, index;
  final GestureTapCallback? onTap;
  final bool isSelectedShow;

  const CharacterLayout(
      {Key? key,
      this.data,
      this.index,
      this.selectIndex,
      this.onTap,
      this.isSelectedShow = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Stack(children: [
        Hero(
          tag: "chat$index",
          child: SizedBox(
              child: Image.network(data["image"]!,
                  height: Sizes.s80, width: Sizes.s80)),
        ),
        if (isSelectedShow)
          if (selectIndex == index)
            Stack(alignment: Alignment.center, children: [
              const SizedBox(height: Sizes.s80, width: Sizes.s80).decorated(
                  color: appCtrl.appTheme.black.withOpacity(0.5),
                  borderRadius:
                      const BorderRadius.all(Radius.circular(AppRadius.r10))),
              Image.asset(eImageAssets.tick,
                  height: Sizes.s22, width: Sizes.s22)
            ])
      ]),
      const VSpace(Sizes.s8),
      Text(data["title"].toString().tr,
          style: AppCss.outfitMedium14.textColor(appCtrl.appTheme.lightText))
    ]).inkWell(onTap: onTap);
  }
}
