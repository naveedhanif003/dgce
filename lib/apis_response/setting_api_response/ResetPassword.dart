/// title : "Reset Password"
/// link : "https://test.dhinvest.ae/api/verify-forget-otp?is_httpClient=1&reset_code=&password=&password_confirmation="
/// method : "post"
/// type : "httpClient"

class ResetPassword {
  ResetPassword({
      this.title, 
      this.link, 
      this.method, 
      this.type,});

  ResetPassword.fromJson(dynamic json) {
    title = json['title'];
    link = json['link'];
    method = json['method'];
    type = json['type'];
  }
  String? title;
  String? link;
  String? method;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['link'] = link;
    map['method'] = method;
    map['type'] = type;
    return map;
  }

}