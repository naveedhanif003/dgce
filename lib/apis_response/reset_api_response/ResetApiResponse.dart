import 'Data.dart';

/// success : true
/// message : "Password reset successful, please login"
/// data : {"nextUrl":"https://test.dhinvest.ae/login"}
/// error : ""

class ResetApiResponse {
  ResetApiResponse({
      this.success, 
      this.message, 
      this.data, 
      this.error,});

  ResetApiResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }
  bool? success;
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