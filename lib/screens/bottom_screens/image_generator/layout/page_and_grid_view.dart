import '../../../../config.dart';

class PageAndGridView extends StatelessWidget {
  const PageAndGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageGeneratorController>(builder: (imageGeneratorCtrl) {
      return Column(children: [
        imageGeneratorCtrl.imageGPTModel != null
            ? imageGeneratorCtrl.viewValue == appFonts.gridType
                ? GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: imageGeneratorCtrl.imageGPTModel!.data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return ImageLayout(
                              data: imageGeneratorCtrl.imageGPTModel!.data[index].url)
                          .inkWell(
                              onTap: () => Get.toNamed(routeName.imagePreview,
                                  arguments: imageGeneratorCtrl.imageGPTModel!.data[index].url));
                    },
                  )
                : Column(
                    children: imageGeneratorCtrl.imageGPTModel!.data
                        .asMap()
                        .entries
                        .map((e) => ImageLayout(
                                height: Sizes.s400,
                                width: MediaQuery.of(context).size.width,
                                data: e.value.url)
                            .inkWell(
                                onTap: () => Get.toNamed(routeName.imagePreview,
                                    arguments: e.value.url))
                            .paddingOnly(bottom: Insets.i15))
                        .toList())
            : Column(children: [
                Image.asset(eImageAssets.noSearch, height: Sizes.s180),
                const VSpace(Sizes.s15),
                SizedBox(
                    width: Sizes.s292,
                    child: Text(appFonts.youHaveNotYet.tr,
                        textAlign: TextAlign.center,
                        style: AppCss.outfitMedium14
                            .textColor(appCtrl.appTheme.lightText)
                            .textHeight(1.3)))
              ]).paddingOnly(top: MediaQuery.of(context).size.height * 0.06)
      ]);
    });
  }
}
