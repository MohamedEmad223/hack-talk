class ComputerVisionModel{
  double? time;
  String? bodyLanguageClass;

  ComputerVisionModel({this.time, this.bodyLanguageClass});

  ComputerVisionModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    bodyLanguageClass = json['body_language_class'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['body_language_class'] = bodyLanguageClass;
    return data;
  }
}