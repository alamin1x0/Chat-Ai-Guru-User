import '../../../config.dart';

class EcommerceScreen extends StatelessWidget {
  final eCommCtrl = Get.put(EcommerceController());

  EcommerceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EcommerceController>(builder: (_) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: appCtrl.appTheme.bg1,
          appBar: AppAppBarCommon(
              isBalanceShow: false,
              title: appFonts.ecommerceDetail,
              leadingOnTap: () => Get.back()),
          body: SingleChildScrollView(
              child: Column(children: [
            textCommon.outfitSemiBoldPrimary16(text: appFonts.chooseOneOfThese),
            const VSpace(Sizes.s10),
            Column(
                    children: eCommCtrl.ecommerceLists
                        .asMap()
                        .entries
                        .map((e) => SocialMediaListLayout(
                            data: e.value,
                            index: e.key,
                            totalLength: eCommCtrl.ecommerceLists.length - 1,
                            onTap: () => eCommCtrl.onTapEcommerce(e.value)))
                        .toList())
                .paddingSymmetric(vertical: Insets.i20, horizontal: Insets.i15)
                .authBoxExtension()
          ]).paddingSymmetric(vertical: Insets.i30, horizontal: Insets.i20)));
    });
  }
}
