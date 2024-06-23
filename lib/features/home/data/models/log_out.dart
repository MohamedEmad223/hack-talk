class LogoutModel {
  final String? message;
  final String? status;

  LogoutModel({this.message, this.status});

  factory LogoutModel.fromJson(Map<String, dynamic> json) {
    return LogoutModel(
      message: json['message'],
      status: json['status'],
    );
  }
}