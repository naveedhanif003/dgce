/// success : true
/// message : "Email verification code send"
/// data : {}
/// error : ""

class ResendCodeResponse {
  ResendCodeResponse({
      this.success, 
      this.message, 
      this.data, 
      this.error,});

  ResendCodeResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
    error = json['error'];
  }
  bool? success;
  String? message;
  dynamic data;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['data'] = data;
    map['error'] = error;
    return map;
  }

}