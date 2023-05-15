class QuestionSuggestionsModel {
  int? id;
  List<PreBuildQuestions>? preBuildQuestions;

  QuestionSuggestionsModel({this.id, this.preBuildQuestions});

  QuestionSuggestionsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['preBuildQuestions'] != null) {
      preBuildQuestions = <PreBuildQuestions>[];
      json['preBuildQuestions'].forEach((v) {
        preBuildQuestions!.add(PreBuildQuestions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (preBuildQuestions != null) {
      data['preBuildQuestions'] =
          preBuildQuestions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreBuildQuestions {
  String? title;

  PreBuildQuestions({this.title});

  PreBuildQuestions.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    return data;
  }
}