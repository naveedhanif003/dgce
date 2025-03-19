import 'PromotionalBanner.dart';
import 'NavbarLinks.dart';
import 'Customer.dart';

/// promotional_banner : {"found":false,"banner_url":null,"redirect_url":null}
/// navbar_links : [{"slug":"contact_us","title":"Contact Us","link":"https://test.dhinvest.ae/contact-us?is_httpClient=1","method":"get","type":"web_view"},{"slug":"privacy_policy","title":"Privacy Policy","link":"https://test.dhinvest.ae/privacy-policy?is_httpClient=1","method":"get","type":"web_view"},{"slug":"terms_condition","title":"Terms and Conditions","link":"https://test.dhinvest.ae/term-condition?is_httpClient=1","method":"get","type":"web_view"},{"slug":"delete_account","title":"Delete My Account","link":"https://test.dhinvest.ae/delete-my-account?is_httpClient=1","method":"get","type":"web_view"}]
/// customer : {"login":{"title":"Login","link":"https://test.dhinvest.ae/api/login","method":"post","type":"httpClient"},"logout":{"title":"Logout?","link":"https://test.dhinvest.ae/api/logout?user_type=customer","method":"get","type":"httpClient"},"signup":{"title":"Signup","link":"https://test.dhinvest.ae/api/user-signup?is_httpClient=1&user_type=customer","method":"post","type":"httpClient"},"forget_password":{"title":"Forgot Password?","link":"https://test.dhinvest.ae/api/forget-password?is_httpClient=1&email=","method":"post","type":"httpClient"},"reset_password":{"title":"Reset Password","link":"https://test.dhinvest.ae/api/verify-forget-otp?is_httpClient=1&reset_code=&password=&password_confirmation=","method":"post","type":"httpClient"},"validate_access_token":{"title":"Validate Access Token","link":"https://test.dhinvest.ae/api/app/get-user-profile?user_type=customer","method":"post","type":"httpClient"},"verify_email":{"title":"Verify Email","link":"https://test.dhinvest.ae/api/verify-email-code?otp=&email=&access_token=","method":"post","type":"httpClient"}}

class Pages {
  Pages({
      this.promotionalBanner, 
      this.navbarLinks, 
      this.customer,});

  Pages.fromJson(dynamic json) {
    promotionalBanner = json['promotional_banner'] != null ? PromotionalBanner.fromJson(json['promotional_banner']) : null;
    if (json['navbar_links'] != null) {
      navbarLinks = [];
      json['navbar_links'].forEach((v) {
        navbarLinks?.add(NavbarLinks.fromJson(v));
      });
    }
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }
  PromotionalBanner? promotionalBanner;
  List<NavbarLinks>? navbarLinks;
  Customer? customer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (promotionalBanner != null) {
      map['promotional_banner'] = promotionalBanner?.toJson();
    }
    if (navbarLinks != null) {
      map['navbar_links'] = navbarLinks?.map((v) => v.toJson()).toList();
    }
    if (customer != null) {
      map['customer'] = customer?.toJson();
    }
    return map;
  }

}