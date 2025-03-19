/// success : true
/// message : "Logout successful"
/// data : {}
/// error : ""

class LogoutResponse {
  LogoutResponse({
    dynamic success,
      String? message, 
      dynamic data, 
      String? error,}){
    _success = success;
    _message = message;
    _data = data;
    _error = error;
}

  LogoutResponse.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _data = json['data'];
    _error = json['error'];
  }
  dynamic _success;
  String? _message;
  dynamic _data;
  String? _error;
LogoutResponse copyWith({  dynamic success,
  String? message,
  dynamic data,
  String? error,
}) => LogoutResponse(  success: success ?? _success,
  message: message ?? _message,
  data: data ?? _data,
  error: error ?? _error,
);
  dynamic get success => _success;
  String? get message => _message;
  dynamic get data => _data;
  String? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['data'] = _data;
    map['error'] = _error;
    return map;
  }

}