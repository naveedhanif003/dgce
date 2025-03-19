import 'Login.dart';
import 'Logout.dart';
import 'Signup.dart';
import 'ForgetPassword.dart';
import 'ResetPassword.dart';
import 'ValidateAccessToken.dart';
import 'VerifyEmail.dart';

/// login : {"title":"Login","link":"https://test.dhinvest.ae/api/login","method":"post","type":"httpClient"}
/// logout : {"title":"Logout?","link":"https://test.dhinvest.ae/api/logout?user_type=customer","method":"get","type":"httpClient"}
/// signup : {"title":"Signup","link":"https://test.dhinvest.ae/api/user-signup?is_httpClient=1&user_type=customer","method":"post","type":"httpClient"}
/// forget_password : {"title":"Forgot Password?","link":"https://test.dhinvest.ae/api/forget-password?is_httpClient=1&email=","method":"post","type":"httpClient"}
/// reset_password : {"title":"Reset Password","link":"https://test.dhinvest.ae/api/verify-forget-otp?is_httpClient=1&reset_code=&password=&password_confirmation=","method":"post","type":"httpClient"}
/// validate_access_token : {"title":"Validate Access Token","link":"https://test.dhinvest.ae/api/app/get-user-profile?user_type=customer","method":"post","type":"httpClient"}
/// verify_email : {"title":"Verify Email","link":"https://test.dhinvest.ae/api/verify-email-code?otp=&email=&access_token=","method":"post","type":"httpClient"}

class Customer {
  Customer({
      this.login, 
      this.logout, 
      this.signup, 
      this.forgetPassword, 
      this.resetPassword, 
      this.validateAccessToken, 
      this.verifyEmail,});

  Customer.fromJson(dynamic json) {
    login = json['login'] != null ? Login.fromJson(json['login']) : null;
    logout = json['logout'] != null ? Logout.fromJson(json['logout']) : null;
    signup = json['signup'] != null ? Signup.fromJson(json['signup']) : null;
    forgetPassword = json['forget_password'] != null ? ForgetPassword.fromJson(json['forget_password']) : null;
    resetPassword = json['reset_password'] != null ? ResetPassword.fromJson(json['reset_password']) : null;
    validateAccessToken = json['validate_access_token'] != null ? ValidateAccessToken.fromJson(json['validate_access_token']) : null;
    verifyEmail = json['verify_email'] != null ? VerifyEmail.fromJson(json['verify_email']) : null;
  }
  Login? login;
  Logout? logout;
  Signup? signup;
  ForgetPassword? forgetPassword;
  ResetPassword? resetPassword;
  ValidateAccessToken? validateAccessToken;
  VerifyEmail? verifyEmail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (login != null) {
      map['login'] = login?.toJson();
    }
    if (logout != null) {
      map['logout'] = logout?.toJson();
    }
    if (signup != null) {
      map['signup'] = signup?.toJson();
    }
    if (forgetPassword != null) {
      map['forget_password'] = forgetPassword?.toJson();
    }
    if (resetPassword != null) {
      map['reset_password'] = resetPassword?.toJson();
    }
    if (validateAccessToken != null) {
      map['validate_access_token'] = validateAccessToken?.toJson();
    }
    if (verifyEmail != null) {
      map['verify_email'] = verifyEmail?.toJson();
    }
    return map;
  }

}