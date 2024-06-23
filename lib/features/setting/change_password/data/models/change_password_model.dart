class ChangePasswordModel {
  int? status;
  String? message;
  dynamic data;
  ChangePasswordModel({
    this.status,
    this.message,
     this.data,
  });

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }


}
