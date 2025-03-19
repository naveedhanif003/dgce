/// title : "Login"
/// link : "https://test.dhinvest.ae/api/login"
/// method : "post"
/// type : "httpClient"

class Login {
  Login({
      this.title, 
      this.link, 
      this.method, 
      this.type,});

  Login.fromJson(dynamic json) {
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