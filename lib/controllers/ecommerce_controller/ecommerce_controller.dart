import '../../config.dart';

class EcommerceController extends GetxController {
  List ecommerceLists = [];

  onTapEcommerce(data) {
    if (data["title"] == appFonts.amazonProductFeature) {
      Get.toNamed(routeName.amazonProductFeatureScreen);
    } else if (data["title"] == appFonts.amazonProductListing) {
      Get.toNamed(routeName.amazonProductListingScreen);
    } else if (data["title"] == appFonts.amazonProductReview) {
      Get.toNamed(routeName.amazonProductReviewScreen);
    }else if (data["title"] == appFonts.amazonProductTitle) {
      Get.toNamed(routeName.amazonProductTitleScreen);
    }
    update();
  }

  @override
  void onReady() {
    ecommerceLists = appArray.ecommerceList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
