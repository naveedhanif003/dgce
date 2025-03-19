import 'Shopping.dart';
import 'ShareBuy.dart';
import 'CartPage.dart';
import 'EditProfile.dart';

/// shopping : {"title":"Buy Products","link":"https://test.dhinvest.ae/products-shop?is_httpClient=1&user_type=customer&access_token=TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA%3D%3D","method":"get","type":"web_view"}
/// share_buy : {"title":"Buy Share","link":"https://test.dhinvest.ae/gold-share?is_httpClient=1&user_type=customer&access_token=TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA%3D%3D","method":"get","type":"web_view"}
/// cart_page : {"title":"Cart Page","link":"https://test.dhinvest.ae/customer/my-cart?is_httpClient=1&user_type=customer&access_token=TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA%3D%3D","method":"get","type":"web_view"}
/// edit_profile : {"title":"User Profile","link":"https://test.dhinvest.ae/customer/profile?is_httpClient=1&user_type=customer&access_token=TXJjVHliV1pRR2pITGhqOWYwbU5IVTExNmdVSUF2V2RRdDFqRDd3d0dLVmNodTk0bjlYb2Z4aEkrL2JiZGdNdA%3D%3D","method":"get","type":"web_view"}

class AppLinks {
  AppLinks({
      this.shopping, 
      this.shareBuy, 
      this.cartPage, 
      this.editProfile,});

  AppLinks.fromJson(dynamic json) {
    shopping = json['shopping'] != null ? Shopping.fromJson(json['shopping']) : null;
    shareBuy = json['share_buy'] != null ? ShareBuy.fromJson(json['share_buy']) : null;
    cartPage = json['cart_page'] != null ? CartPage.fromJson(json['cart_page']) : null;
    editProfile = json['edit_profile'] != null ? EditProfile.fromJson(json['edit_profile']) : null;
  }
  Shopping? shopping;
  ShareBuy? shareBuy;
  CartPage? cartPage;
  EditProfile? editProfile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (shopping != null) {
      map['shopping'] = shopping?.toJson();
    }
    if (shareBuy != null) {
      map['share_buy'] = shareBuy?.toJson();
    }
    if (cartPage != null) {
      map['cart_page'] = cartPage?.toJson();
    }
    if (editProfile != null) {
      map['edit_profile'] = editProfile?.toJson();
    }
    return map;
  }

}