class TranslateLanguage {
  String? language;
  String? code;

  TranslateLanguage({this.language, this.code});

  TranslateLanguage.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language'] = language;
    data['code'] = code;
    return data;
  }
}