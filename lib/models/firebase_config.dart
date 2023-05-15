import 'package:probot/common/assets/index.dart';

class FirebaseConfigModel {
  String? bannerAddId,
      bannerIOSId,
      rewardAndroidId,
      rewardIOSId,
      chatGPTKey,
      interstitialAdIdAndroid,
      interstitialAdIdIOS,
      privacyPolicyLink,
      rateAppAndroidId,
      rateAppIOSId,
      refundLink,
      facebookAddAndroidId,
      facebookInterstitialAd,
      facebookRewardAd,
      facebookAddIOSId,
      facebookInterstitialIOSAd,
      facebookRewardIOSAd,
      splashLogo,
      drawerLogo,
      homeLogo;
  bool? isChatShow, isCategorySuggestion, isVoiceEnable, isCameraEnable;
  bool? isImageGeneratorShow;
  int? balance,rewardPoint;
  bool? isTextCompletionShow;
  bool? isTheme, isRTL;
  bool? isAddShow,
      isChatHistory,
      isGuestLoginEnable,
      isGoogleAdmobEnable;

  FirebaseConfigModel(
      {this.bannerAddId,
      this.bannerIOSId,
        this.isRTL,
      this.chatGPTKey,
      this.interstitialAdIdAndroid,
      this.interstitialAdIdIOS,
      this.privacyPolicyLink,
      this.refundLink,
      this.rateAppAndroidId,
      this.rateAppIOSId,
      this.isChatShow,
      this.isImageGeneratorShow,
      this.rewardAndroidId,
      this.rewardIOSId,
      this.facebookAddAndroidId,
      this.facebookInterstitialAd,
      this.facebookRewardAd,
      this.facebookAddIOSId,
      this.facebookInterstitialIOSAd,
      this.facebookRewardIOSAd,
      this.splashLogo,
      this.drawerLogo,
      this.homeLogo,
      this.isTextCompletionShow,
      this.isAddShow,
      this.isCategorySuggestion,
      this.isVoiceEnable,
      this.isCameraEnable,
      this.isTheme,
      this.isChatHistory,
      this.isGuestLoginEnable,
      this.isGoogleAdmobEnable,
      this.balance,this.rewardPoint});

  FirebaseConfigModel.fromJson(Map<String, dynamic> json) {
    bannerAddId = json['bannerAddId'] ?? "";
    bannerIOSId = json['bannerIOSId'] ?? "";
    rewardAndroidId = json['rewardAndroidId'] ?? "true";
    rewardIOSId = json['rewardIOSId'] ?? "";
    chatGPTKey = json['chatGPTKey'];
    interstitialAdIdAndroid = json['interstitialAdIdAndroid'] ?? "";
    interstitialAdIdIOS = json['interstitialAdIdIOS'] ?? "";
    privacyPolicyLink = json['privacyPolicyLink'] ?? "";
    refundLink = json['refundLink'] ?? "";
    rateAppAndroidId = json['rateAppAndroidId'] ?? "";
    rateAppIOSId = json['rateAppIOSId'] ?? "";
    facebookAddAndroidId = json['facebookAddAndroidId'] ?? "";
    facebookInterstitialAd = json['facebookInterstitialAd'] ?? "";
    facebookRewardAd = json['facebookRewardAd'] ?? "";
    facebookAddIOSId = json['facebookAddIOSId'] ?? "";
    facebookInterstitialIOSAd = json['facebookInterstitialIOSAd'] ?? "";
    facebookRewardIOSAd = json['facebookRewardIOSAd'] ?? "";
    splashLogo = json['splashLogo'] ?? eImageAssets.logo1;
    drawerLogo = json['drawerLogo'] ?? "";
    homeLogo = json['homeLogo'] ?? "";
    isChatShow = json['isChatShow'] ?? true;
    isImageGeneratorShow = json['isImageGeneratorShow'] ?? true;
    isTextCompletionShow = json['isTextCompletionShow'] ?? true;
    isChatHistory = json['isChatHistory'] ?? true;
    isAddShow = json['isAddShow'] ?? true;
    isCategorySuggestion = json['isCategorySuggestion'] ?? true;
    isVoiceEnable = json['isVoiceEnable'] ?? true;
    isCameraEnable = json['isCameraEnable'] ?? true;
    isRTL = json['isRTL'] ?? false;
    isTheme = json['isTheme'] ?? false;
    isGuestLoginEnable = json['isGuestLoginEnable'] ?? true;
    isGoogleAdmobEnable = json['isGoogleAdmobEnable'] ?? true;
    balance = json['balance'] ?? 5;
    rewardPoint = json['rewardPoint'] ?? 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bannerAddId'] = bannerAddId;
    data['bannerIOSId'] = bannerIOSId;
    data['chatGPTKey'] = chatGPTKey;
    data['interstitialAdIdAndroid'] = interstitialAdIdAndroid;
    data['interstitialAdIdIOS'] = interstitialAdIdIOS;
    data['privacyPolicyLink'] = privacyPolicyLink;
    data['refundLink'] = refundLink;
    data['rateAppAndroidId'] = rateAppAndroidId;
    data['rateAppIOSId'] = rateAppIOSId;
    data['facebookAddAndroidId'] = facebookAddAndroidId;
    data['facebookInterstitialAd'] = facebookInterstitialAd;
    data['facebookRewardAd'] = facebookRewardAd;
    data['facebookAddIOSId'] = facebookAddIOSId;
    data['facebookInterstitialIOSAd'] = facebookInterstitialIOSAd;
    data['facebookRewardIOSAd'] = facebookRewardIOSAd;
    data['splashLogo'] = splashLogo;
    data['drawerLogo'] = drawerLogo;
    data['homeLogo'] = homeLogo;
    data['isChatShow'] = isChatShow;
    data['isImageGeneratorShow'] = isImageGeneratorShow;
    data['isTextCompletionShow'] = isTextCompletionShow;
    data['isAddShow'] = isAddShow;
    data['rewardIOSId'] = rewardIOSId;
    data['rewardAndroidId'] = rewardAndroidId;
    data['isChatHistory'] = isChatHistory;
    data['isRTL'] = isRTL;
    data['isCategorySuggestion'] = isCategorySuggestion;
    data['isVoiceEnable'] = isVoiceEnable;
    data['isCameraEnable'] = isCameraEnable;
    data['isGuestLoginEnable'] = isGuestLoginEnable;
    data['isGoogleAdmobEnable'] = isGoogleAdmobEnable;
    data['balance'] = balance;
    data['rewardPoint'] = rewardPoint;
    return data;
  }
}
