import 'UserRoles.dart';

/// name : "Customer Two"
/// image : "https://test.dhinvest.ae/public/assets/administration/images/dummy_person.png"
/// dashboard_url : "https://test.dhinvest.ae/httpClient/authorized/web-view/entry-point?is_httpClient=1&user_type=customer&access_token=TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA%3D%3D"
/// user_roles : [{"id":3,"name":"Customer","slug":"customer","created_at":"2025-02-26T07:37:52.000000Z","updated_at":"2025-02-26T07:37:52.000000Z","pivot":{"user_id":7,"role_id":3}}]

class UserData {
  UserData({
      this.name, 
      this.image, 
      this.dashboardUrl, 
      this.userRoles,});

  UserData.fromJson(dynamic json) {
    name = json['name'];
    image = json['image'];
    dashboardUrl = json['dashboard_url'];
    if (json['user_roles'] != null) {
      userRoles = [];
      json['user_roles'].forEach((v) {
        userRoles?.add(UserRoles.fromJson(v));
      });
    }
  }
  String? name;
  String? image;
  String? dashboardUrl;
  List<UserRoles>? userRoles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['image'] = image;
    map['dashboard_url'] = dashboardUrl;
    if (userRoles != null) {
      map['user_roles'] = userRoles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}