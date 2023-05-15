import '../../../../config.dart';

class FilterLayout extends StatelessWidget {
  const FilterLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageGeneratorController>(
      builder: (imageGeneratorCtrl) {
        return SizedBox(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFieldCommon(
                  hintText: appFonts.search,
                  fillColor: appCtrl.appTheme.surface,
                  prefixIcon:
                  SvgPicture.asset(eSvgAssets.search, fit: BoxFit.scaleDown)
                      .inkWell(onTap: () {}),
                  suffixIcon: SizedBox(
                      height: 10,
                      width: 5,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const VerticalDivider(
                                width: 1,
                                thickness: 2,
                                indent: 10,
                                endIndent: 10),
                            SvgPicture.asset(eSvgAssets.filter)
                                .inkWell(
                                onTap: () => imageGeneratorCtrl.onTapFilter())
                                .paddingSymmetric(horizontal: Insets.i10)
                          ]))),
              const VSpace(Sizes.s6),
              SizedBox(
                child: Column(children: [
                  Row(children: [
                    DropDownLayout(
                        value: imageGeneratorCtrl.noOfImagesValue,
                        title: appFonts.noOfImages,
                        hintText: imageGeneratorCtrl.noOfImagesLists.first,
                        dropDownList: imageGeneratorCtrl.noOfImagesLists
                            .asMap()
                            .entries
                            .map((e) => DropdownMenuItem(
                            value: e.value, child: Text(e.value)))
                            .toList(),
                        onChanged: (val) {
                          imageGeneratorCtrl.noOfImagesValue = val.toString();
                          imageGeneratorCtrl.update();
                        }),
                    const HSpace(Sizes.s15),
                    DropDownLayout(
                        value: imageGeneratorCtrl.imageStyleValue,
                        title: appFonts.imageStyle,
                        hintText: imageGeneratorCtrl.imageStyleLists.first,
                        dropDownList: imageGeneratorCtrl.imageStyleLists
                            .asMap()
                            .entries
                            .map((e) => DropdownMenuItem(
                            value: e.value, child: Text(e.value)))
                            .toList(),
                        onChanged: (val) {
                          imageGeneratorCtrl.imageStyleValue = val.toString();
                          imageGeneratorCtrl.update();
                        })
                  ]),
                  const VSpace(Sizes.s15),
                  Row(children: [
                    DropDownLayout(
                        value: imageGeneratorCtrl.moodValue,
                        title: appFonts.mood,
                        hintText: imageGeneratorCtrl.moodLists.first,
                        dropDownList: imageGeneratorCtrl.moodLists
                            .asMap()
                            .entries
                            .map((e) => DropdownMenuItem(
                            value: e.value, child: Text(e.value)))
                            .toList(),
                        onChanged: (val) {
                          imageGeneratorCtrl.moodValue = val.toString();
                          imageGeneratorCtrl.update();
                        }),
                    const HSpace(Sizes.s15),
                    DropDownLayout(
                        value: imageGeneratorCtrl.imageColorValue,
                        title: appFonts.imageColor,
                        hintText: imageGeneratorCtrl.imageColorLists.first,
                        dropDownList: imageGeneratorCtrl.imageColorLists
                            .asMap()
                            .entries
                            .map((e) => DropdownMenuItem(
                            value: e.value, child: Text(e.value)))
                            .toList(),
                        onChanged: (val) {
                          imageGeneratorCtrl.imageColorValue = val.toString();
                          imageGeneratorCtrl.update();
                        })
                  ]),
                  const VSpace(Sizes.s20),
                  Row(children: [
                    Expanded(
                        child: ButtonCommon(
                            onTap: () => imageGeneratorCtrl.onTapFilter(),
                            title: appFonts.cancel,
                            isGradient: false,
                            style: AppCss.outfitMedium16
                                .textColor(appCtrl.appTheme.primary),
                            color: appCtrl.appTheme.trans,
                            borderColor: appCtrl.appTheme.primary)),
                    const HSpace(Sizes.s15),
                    Expanded(
                        child: ButtonCommon(
                            onTap: () => imageGeneratorCtrl.onTapFilter(),
                            title: appFonts.apply))
                  ])
                ]).paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15),
              ).decorated(
                  color: appCtrl.appTheme.sameWhite,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(AppRadius.r8)))
            ])).padding(
            horizontal: Insets.i20,
            top: MediaQuery.of(context).size.height * 0.15);
      }
    );
  }
}
