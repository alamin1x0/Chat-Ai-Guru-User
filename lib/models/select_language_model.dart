import 'dart:ui';

class SelectLanguageModel {
  String? image;
  String? title;
  String? code;
  Locale? locale;

  SelectLanguageModel({this.image, this.title,this.code,this.locale});

  SelectLanguageModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    code = json['code'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    data['code'] = code;
    data['locale'] = locale;
    return data;
  }
}
