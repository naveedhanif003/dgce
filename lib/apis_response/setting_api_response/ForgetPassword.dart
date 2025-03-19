/// title : "Forgot Password?"
/// link : "https://test.dhinvest.ae/api/forget-password?is_httpClient=1&email="
/// method : "post"
/// type : "httpClient"

class ForgetPassword {
  ForgetPassword({
      this.title, 
      this.link, 
      this.method, 
      this.type,});

  ForgetPassword.fromJson(dynamic json) {
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