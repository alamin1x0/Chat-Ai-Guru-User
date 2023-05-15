import '../../config.dart';

class PersonalAdvisorController extends GetxController {
  List personalAdvisorLists = [];

  onGoPage(value) {
    if (value["title"] == appFonts.babyNameSuggestion) {
      Get.toNamed(routeName.babyNameScreen);
    } else if (value["title"] == appFonts.cvMaker) {
      Get.toNamed(routeName.cvMakerScreen);
    } else if (value["title"] == appFonts.giftSuggestion) {
      Get.toNamed(routeName.giftSuggestionScreen);
    } else if (value["title"] == appFonts.birthdayMessage) {
      Get.toNamed(routeName.birthdayMessageScreen);
    } else if (value["title"] == appFonts.anniversaryMessage) {
      Get.toNamed(routeName.anniversaryMessageScreen);
    } else if (value["title"] == appFonts.newBabyWishes) {
      Get.toNamed(routeName.newBabyWishesScreen);
    } else if (value["title"] == appFonts.getWellMessage) {
      Get.toNamed(routeName.getWellMessageScreen);
    } else if (value["title"] == appFonts.valentineDay) {
      Get.toNamed(routeName.valentineScreen);
    } else if (value["title"] == appFonts.newYearWishes) {
      Get.toNamed(routeName.newYearGreetingScreen);
    } else if (value["title"] == appFonts.mothersDayWishes) {
      Get.toNamed(routeName.mothersDayWishesScreen);
    } else if (value["title"] == appFonts.fathersDayWishes) {
      Get.toNamed(routeName.fathersDayWishesScreen);
    } else if (value["title"] == appFonts.promotionWishes) {
      Get.toNamed(routeName.promotionWishesScreen);
    } else if (value["title"] == appFonts.babyShowerMessage) {
      Get.toNamed(routeName.babyShowerScreen);
    } else if (value["title"] == appFonts.farewellMessage) {
      Get.toNamed(routeName.farewellMessageScreen);
    } else {
      Get.toNamed(routeName.weddingWishesScreen);
    }
  }

  @override
  void onReady() {
    addCtrl.onInterstitialAdShow();
    personalAdvisorLists = appArray.personalAdvisorList;
    update();
    // TODO: implement onReady
    super.onReady();
  }
}
