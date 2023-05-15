import '../../../../config.dart';

class TopLayout extends StatelessWidget {
  const TopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ImageGeneratorController>(builder: (imageGeneratorCtrl) {

      return Column(children: [
        TextFieldCommon(
          controller: imageGeneratorCtrl.imageTextController,
            hintText: appFonts.search,
            fillColor: appCtrl.appTheme.surface,
            prefixIcon:
                SvgPicture.asset(eSvgAssets.search, fit: BoxFit.scaleDown)
                    .inkWell(onTap: () {}),
           ).authBoxExtension(),
        const VSpace(Sizes.s10),
        SizedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
              DropDownLayout(
                  value: imageGeneratorCtrl.imageValue,
                  title: appFonts.imageSize,
                  hintText: appFonts.selectSize,
                  dropDownList: imageGeneratorCtrl.imageSizeLists
                      .asMap()
                      .entries
                      .map((e) => DropdownMenuItem(
                          value: e.value, child: Text(e.value)))
                      .toList(),
                  onChanged: (val) async{
                    imageGeneratorCtrl.imageValue = val.toString();
                    imageGeneratorCtrl.update();
                    await imageGeneratorCtrl.getGPTImage(
                        imageText: imageGeneratorCtrl
                            .imageTextController.text
                            .trim(),
                        size: val.toString());
                  }),
              const HSpace(Sizes.s15),
              DropDownLayout(
                  value: imageGeneratorCtrl.viewValue,
                  title: appFonts.viewType,
                  hintText: appFonts.selectType,
                  dropDownList: imageGeneratorCtrl.viewTypeLists
                      .asMap()
                      .entries
                      .map((e) => DropdownMenuItem(
                          value: e.value, child: Text(e.value.toString().tr)))
                      .toList(),
                  onChanged: (val) {
                    imageGeneratorCtrl.viewValue = val.toString();
                    imageGeneratorCtrl.update();
                  })
            ]).paddingAll(Insets.i15))
            .authBoxExtension()
      ]);
    });
  }
}
/*suffixIcon: SizedBox(
                height: 10,
                width: 5,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const VerticalDivider(
                          width: 1, thickness: 2, indent: 10, endIndent: 10),
                      SvgPicture.asset(eSvgAssets.filter)
                          .inkWell(
                              onTap: () => imageGeneratorCtrl.onTapFilter())
                          .paddingSymmetric(horizontal: Insets.i10)
                    ]))*/