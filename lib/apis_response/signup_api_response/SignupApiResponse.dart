import 'Data.dart';

/// success : true
/// message : "Registration successful, please verify your account"
/// data : {"access_token":"UXdjblZ5QkoxL25LNUxuRGtQSDdHcTdjVStHQzd4WGhOTG01eFp3bXJqa1FZTnBiYWNtZXNXT0JlOUIwUy9CZ1Q3NkQ0S05OYTYrSGptWUlhcVlWMHc9PQ=="}
/// error : "Verify your account first!"

class SignupApiResponse {
  SignupApiResponse({
    dynamic success,
      String? message, 
      Data? data, 
      String? error,}){
    _success = success;
    _message = message;
    _data = data;
    _error = error;
}

  SignupApiResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    _error = json['error'];
  }
  dynamic _success;
  String? _message;
  Data? _data;
  String? _error;
SignupApiResponse copyWith({  dynamic success,
  String? message,
  Data? data,
  String? error,
}) => SignupApiResponse(  success: success ?? _success,
  message: message ?? _message,
  data: data ?? _data,
  error: error ?? _error,
);
  dynamic get success => _success;
  String? get message => _message;
  Data? get data => _data;
  String? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    map['error'] = _error;
    return map;
  }

}