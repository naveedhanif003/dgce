/// title : "Validate Access Token"
/// link : "https://test.dhinvest.ae/api/app/get-user-profile?user_type=customer"
/// method : "post"
/// type : "httpClient"

class ValidateAccessToken {
  ValidateAccessToken({
      this.title, 
      this.link, 
      this.method, 
      this.type,});

  ValidateAccessToken.fromJson(dynamic json) {
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