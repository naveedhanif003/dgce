import 'Data.dart';

/// success : true
/// message : "Startup data found"
/// data : {"is_access_token_valid":false,"isEmailVerified":null,"userData":null,"pages":{"promotional_banner":{"found":false,"banner_url":null,"redirect_url":null},"navbar_links":[{"slug":"contact_us","title":"Contact Us","link":"https://test.dhinvest.ae/contact-us?is_httpClient=1","method":"get","type":"web_view"},{"slug":"privacy_policy","title":"Privacy Policy","link":"https://test.dhinvest.ae/privacy-policy?is_httpClient=1","method":"get","type":"web_view"},{"slug":"terms_condition","title":"Terms and Conditions","link":"https://test.dhinvest.ae/term-condition?is_httpClient=1","method":"get","type":"web_view"},{"slug":"delete_account","title":"Delete My Account","link":"https://test.dhinvest.ae/delete-my-account?is_httpClient=1","method":"get","type":"web_view"}],"customer":{"login":{"title":"Login","link":"https://test.dhinvest.ae/api/login","method":"post","type":"httpClient"},"logout":{"title":"Logout?","link":"https://test.dhinvest.ae/api/logout?user_type=customer","method":"get","type":"httpClient"},"signup":{"title":"Signup","link":"https://test.dhinvest.ae/api/user-signup?is_httpClient=1&user_type=customer","method":"post","type":"httpClient"},"forget_password":{"title":"Forgot Password?","link":"https://test.dhinvest.ae/api/forget-password?is_httpClient=1&email=","method":"post","type":"httpClient"},"reset_password":{"title":"Reset Password","link":"https://test.dhinvest.ae/api/verify-forget-otp?is_httpClient=1&reset_code=&password=&password_confirmation=","method":"post","type":"httpClient"},"validate_access_token":{"title":"Validate Access Token","link":"https://test.dhinvest.ae/api/app/get-user-profile?user_type=customer","method":"post","type":"httpClient"},"verify_email":{"title":"Verify Email","link":"https://test.dhinvest.ae/api/verify-email-code?otp=&email=&access_token=","method":"post","type":"httpClient"}}},"refresh_url":"https://test.dhinvest.ae/refresh?is_httpClient=1&user_type=customer","welcome_text":"Welcome to DGCE","onBoardingText":{"first":{"title":"Register your DGCE Account Today","description":["Tap to create your free account in seconds.","Securely access digital gold trading on the go.","Join thousands already building their wealth."]},"second":{"title":"Buy Gold Instantly","description":["Purchase digital gold with just a few taps.","Real-time pricing and secure transactions, always.","Diversify your portfolio, right from your phone."]},"third":{"title":"Sell Gold with Ease","description":["Quickly liquidate your gold when you need to.","Get the best market rates, directly in the app.","Fast, secure payouts to your linked account."]},"fourth":{"title":"Daily Profit Potential","description":["Monitor market trends and seize opportunities.","Track your earnings with clear, intuitive charts.","Experience the convenience of growing your wealth daily."]}}}
/// error : ""

class SettingApiResponse {
  SettingApiResponse({
      this.success, 
      this.message, 
      this.data, 
      this.error,});

  SettingApiResponse.fromJson(dynamic json) {
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