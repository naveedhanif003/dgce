/// title : "User Profile"
/// link : "https://test.dhinvest.ae/customer/profile?is_httpClient=1&user_type=customer&access_token=TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA%3D%3D"
/// method : "get"
/// type : "web_view"

class EditProfile {
  EditProfile({
      this.title, 
      this.link, 
      this.method, 
      this.type,});

  EditProfile.fromJson(dynamic json) {
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