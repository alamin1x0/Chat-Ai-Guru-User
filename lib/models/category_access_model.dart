

class CategoryAccessModel {
  bool? isCodeGeneratorEnable,isTranslateAnythingEnable;
  bool? isSocialMediaEnable;
  bool? isEmailGeneratorEnable;
  bool? isPersonalAdvisorEnable,isPasswordGeneratorEnable;
  bool? isTravelEnable,
      isEssayWriterEnable,
      isContentWritingEnable;

  CategoryAccessModel(
      {
      this.isCodeGeneratorEnable,
      this.isSocialMediaEnable,
      this.isEmailGeneratorEnable,
      this.isTravelEnable,
      this.isPasswordGeneratorEnable,
      this.isTranslateAnythingEnable,
      this.isEssayWriterEnable,
      this.isContentWritingEnable,
      this.isPersonalAdvisorEnable});

  CategoryAccessModel.fromJson(Map<String, dynamic> json) {
    isCodeGeneratorEnable = json['isCodeGeneratorEnable'] ?? true;
    isSocialMediaEnable = json['isSocialMediaEnable'] ?? true;
    isEmailGeneratorEnable = json['isEmailGeneratorEnable'] ?? true;
    isTranslateAnythingEnable = json['isTranslateAnythingEnable'] ?? true;
    isPasswordGeneratorEnable = json['isPasswordGeneratorEnable'] ?? false;
    isTravelEnable = json['isTravelEnable'] ?? true;
    isEssayWriterEnable = json['isEssayWriterEnable'] ?? true;
    isContentWritingEnable = json['isContentWritingEnable'] ?? true;
    isPersonalAdvisorEnable = json['isPersonalAdvisorEnable'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isCodeGeneratorEnable'] = isCodeGeneratorEnable;
    data['isSocialMediaEnable'] = isSocialMediaEnable;
    data['isEmailGeneratorEnable'] = isEmailGeneratorEnable;
    data['isTranslateAnythingEnable'] = isTranslateAnythingEnable;
    data['isTravelEnable'] = isTravelEnable;
    data['isContentWritingEnable'] = isContentWritingEnable;
    data['isEssayWriterEnable'] = isEssayWriterEnable;
    return data;
  }
}
