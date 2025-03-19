import 'Data.dart';

/// success : true
/// message : "Login successful"
/// data : {"access_token":"TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA==","isEmailVerified":false,"userData":{"name":"Customer Two","image":"https://test.dhinvest.ae/public/assets/administration/images/dummy_person.png","dashboard_url":"https://test.dhinvest.ae/httpClient/authorized/web-view/entry-point?is_httpClient=1&user_type=customer&access_token=TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA%3D%3D","user_roles":[{"id":3,"name":"Customer","slug":"customer","created_at":"2025-02-26T07:37:52.000000Z","updated_at":"2025-02-26T07:37:52.000000Z","pivot":{"user_id":7,"role_id":3}}]},"appLinks":{"shopping":{"title":"Buy Products","link":"https://test.dhinvest.ae/products-shop?is_httpClient=1&user_type=customer&access_token=TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA%3D%3D","method":"get","type":"web_view"},"share_buy":{"title":"Buy Share","link":"https://test.dhinvest.ae/gold-share?is_httpClient=1&user_type=customer&access_token=TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA%3D%3D","method":"get","type":"web_view"},"cart_page":{"title":"Cart Page","link":"https://test.dhinvest.ae/customer/my-cart?is_httpClient=1&user_type=customer&access_token=TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA%3D%3D","method":"get","type":"web_view"},"edit_profile":{"title":"User Profile","link":"https://test.dhinvest.ae/customer/profile?is_httpClient=1&user_type=customer&access_token=TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA%3D%3D","method":"get","type":"web_view"}}}
/// error : ""

class LoginApiResponse {
  LoginApiResponse({
      this.success, 
      this.message, 
      this.data, 
      this.error,});

  LoginApiResponse.fromJson(dynamic json) {
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