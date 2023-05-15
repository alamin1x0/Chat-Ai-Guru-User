class SelectCharacterModel {
  String? image;
  String? title;

  SelectCharacterModel({this.image, this.title});

  SelectCharacterModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    return data;
  }
}
