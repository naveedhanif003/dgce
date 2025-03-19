import 'Data.dart';

/// success : true
/// message : "Reset password code is sent to your registered email and phone"
/// data : {"nextUrl":"https://test.dhinvest.ae/password/reset"}
/// error : ""

class ForgotApiResponse {
  ForgotApiResponse({
      this.success, 
      this.message, 
      this.data, 
      this.error,});

  ForgotApiResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }
  dynamic success;
  String? message;
  Data? data;
  String? error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['error'] = error;
    return map;
  }

}