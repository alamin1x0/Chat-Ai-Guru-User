class NotificationModel {
  String? image;
  String? title;
  String? subtitle;

  NotificationModel({this.image, this.title, this.subtitle});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    subtitle = json['subtitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    data['subtitle'] = subtitle;
    return data;
  }
}
