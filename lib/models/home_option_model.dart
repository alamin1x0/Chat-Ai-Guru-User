class HomeOptionModel {
  String? image;
  String? title;
  String? desc;

  HomeOptionModel({this.image, this.title, this.desc});

  HomeOptionModel.fromJson(Map<String, dynamic> json) {
    image = json['icon'];
    title = json['title'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['icon'] = image;
    data['title'] = title;
    data['desc'] = desc;
    return data;
  }
}