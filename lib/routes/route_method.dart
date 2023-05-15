import 'package:probot/screens/app_screens/allow_notification_screen/allow_notification_screen.dart';
import '../config.dart';
import '../screens/app_screens/ecommerce_screen/ecommerce_screen.dart';

RouteName _routeName = RouteName();

class AppRoute {
  final List<GetPage> getPages = [
    GetPage(name: _routeName.splashScreen, page: () => SplashScreen()),
    GetPage(name: _routeName.onBoardingScreen, page: () => OnBoardingScreen()),
    GetPage(name: _routeName.loginScreen, page: () => const LoginScreen()),
    GetPage(name: _routeName.signInScreen, page: () => const SignInScreen()),
    GetPage(
        name: _routeName.restPasswordScreen, page: () => RestPasswordScreen()),
    GetPage(
        name: _routeName.changePasswordScreen,
        page: () => const ChangePasswordScreen()),
    GetPage(name: _routeName.signUpScreen, page: () => const SignUpScreen()),
    GetPage(
        name: _routeName.selectLanguageScreen,
        page: () => SelectLanguageScreen()),
    GetPage(
        name: _routeName.selectCharacterScreen,
        page: () => SelectCharacterScreen()),
    GetPage(name: _routeName.mobileLogin, page: () => MobileLogin()),
    GetPage(name: _routeName.dashboard, page: () => Dashboard()),
    GetPage(name: _routeName.chatLayout, page: () => ChatLayout()),
    GetPage(
        name: _routeName.addFingerprintScreen,
        page: () => AddFingerprintScreen()),
    GetPage(
        name: _routeName.notificationsScreen,
        page: () => NotificationsScreen()),
    GetPage(name: _routeName.imagePreview, page: () => ImagePreview()),
    GetPage(
        name: _routeName.backgroundList, page: () => const BackgroundList()),
    GetPage(name: _routeName.myAccountScreen, page: () => MyAccountScreen()),
    GetPage(
        name: _routeName.fingerprintAndLockSecurity,
        page: () => const FingerprintAndLockSecurity()),
    GetPage(
        name: _routeName.privacyPolicyScreen,
        page: () => PrivacyPolicyScreen()),
    GetPage(name: _routeName.chatHistory, page: () => ChatHistoryScreen()),
    GetPage(name: _routeName.quickAdvisor, page: () => QuickAdvisorScreen()),
    GetPage(name: _routeName.translateScreen, page: () =>  TranslateScreen()),
    GetPage(name: _routeName.commonWebView, page: () => const CommonWebView()),
    GetPage(name: _routeName.noInternet, page: () => const NoInternet()),

    GetPage(name: _routeName.translateScreen, page: () => TranslateScreen()),
    GetPage(
        name: _routeName.codeGeneratorScreen,
        page: () => CodeGeneratorScreen()),
    GetPage(
        name: _routeName.emailWriterScreen, page: () => EmailGeneratorScreen()),
    GetPage(
        name: _routeName.socialMediaScreen, page: () => SocialMediaScreen()),
    GetPage(
        name: _routeName.captionCreatorScreen,
        page: () => const CaptionCreatorScreen()),
    GetPage(
        name: _routeName.musicForPostScreen, page: () => const MusicForPostScreen()),
    GetPage(
        name: _routeName.hashtagForPostScreen,
        page: () => const HashtagForPostScreen()),
    GetPage(
        name: _routeName.passwordGeneratorScreen,
        page: () => PasswordGeneratorScreen()),
    GetPage(
        name: _routeName.essayWriterScreen, page: () => EssayWriterScreen()),
    GetPage(name: _routeName.travelScreen, page: () => TravelScreen()),
    GetPage(
        name: _routeName.nearbyPointsScreen, page: () => NearbyPointsScreen()),
    GetPage(
        name: _routeName.distanceAttractionScreen,
        page: () => DistanceAttractionScreen()),
    GetPage(
        name: _routeName.personalAdvisorScreen,
        page: () => PersonalAdvisorScreen()),
    GetPage(name: _routeName.babyNameScreen, page: () => BabyNameScreen()),
    GetPage(name: _routeName.cvMakerScreen, page: () => CvMakerScreen()),
    GetPage(
        name: _routeName.giftSuggestionScreen,
        page: () => GiftSuggestionScreen()),
    GetPage(
        name: _routeName.birthdayMessageScreen,
        page: () => BirthdayMessageScreen()),
    GetPage(
        name: _routeName.anniversaryMessageScreen,
        page: () => AnniversaryMessageScreen()),

    GetPage(name: _routeName.newBabyWishesScreen,page: () => NewBabyWishesScreen()),
    GetPage(name: _routeName.getWellMessageScreen,page: () => GetWellMessageScreen()),

    GetPage(
        name: _routeName.newBabyWishesScreen,
        page: () => NewBabyWishesScreen()),
    GetPage(name: _routeName.translateScreen, page: () => TranslateScreen()),
    GetPage(name: _routeName.commonWebView, page: () => const CommonWebView()),
    GetPage(name: _routeName.noInternet, page: () => const NoInternet()),
    GetPage(name: _routeName.valentineScreen, page: () => ValentineDayScreen()),
    GetPage(name: _routeName.newYearGreetingScreen, page: () => NewYearGreetingScreen()),
    GetPage(name: _routeName.mothersDayWishesScreen, page: () => MothersDayWishesScreen()),
    GetPage(name: _routeName.fathersDayWishesScreen, page: () => FathersDayWishesScreen()),
    GetPage(name: _routeName.promotionWishesScreen, page: () => PromotionWishesScreen()),
    GetPage(name: _routeName.babyShowerScreen, page: () => BabyShowerScreen()),
    GetPage(name: _routeName.farewellMessageScreen, page: () => FarewellMessageScreen()),
    GetPage(name: _routeName.weddingWishesScreen, page: () => WeddingWishesScreen()),
    GetPage(name: _routeName.manageApiKeyScreen, page: () => ManageApiKeyScreen()),
    GetPage(name: _routeName.addApiKeyScreen, page: () => AddApiKeyScreen()),

    GetPage(name: _routeName.contentWriterScreen, page: () => ContentWriterScreen()),

    GetPage(name: _routeName.settingScreen, page: () => Setting()),
    GetPage(name: _routeName.allowNotificationScreen, page: () => AllowNotificationScreen()),
    GetPage(name: _routeName.ecommerceDetailsScreen, page: () => EcommerceScreen()),

  ];
}
