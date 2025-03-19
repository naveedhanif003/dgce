import 'package:dream_al_emarat_app/apis_response/email_verification_api_response/EmailVerificationResponse.dart';
import 'package:dream_al_emarat_app/apis_response/forgot_api_response/ForgotApiResponse.dart';
import 'package:dream_al_emarat_app/apis_response/login_api_response/LoginApiResponse.dart';
import 'package:dream_al_emarat_app/apis_response/logout_response/LogoutResponse.dart';
import 'package:dream_al_emarat_app/apis_response/resend_email_code/ResendCodeResponse.dart';
import 'package:dream_al_emarat_app/apis_response/reset_api_response/ResetApiResponse.dart';
import 'package:dream_al_emarat_app/apis_response/setting_api_response/SettingApiResponse.dart';
import 'package:dream_al_emarat_app/apis_response/signup_api_response/SignupApiResponse.dart';

import '../core/services/network_api_services.dart';

class AppRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<SettingApiResponse> getSettings(
    Map<String, String> setting_params,
  ) async {
    final response = await _apiService.getRequest(
      "/api/get/settings",
      params: setting_params,
    ); // API Endpoint
    return SettingApiResponse.fromJson(response);
  }

  Future<LoginApiResponse> getLogin(Map<String, String> body) async {
    final response = await _apiService.postRequest(
      "/api/login",
      body: body,
    ); // API Endpoint
    return LoginApiResponse.fromJson(response);
  }

  Future<LogoutResponse> getLogout(Map<String, String> body) async {
    final response = await _apiService.postRequest(
      "/api/logout",
      body: body,
    ); // API Endpoint
    return LogoutResponse.fromJson(response);
  }

  Future<SignupApiResponse> getSignup(Map<String, String> body) async {
    final response = await _apiService.postRequest(
      "/api/user-signup",
      body: body,
    ); // API Endpoint
    return SignupApiResponse.fromJson(response);
  }

  Future<ForgotApiResponse> getForgotPass(Map<String, String> body) async {
    final response = await _apiService.postRequest(
      "/api/forget-password",
      body: body,
    ); // API Endpoint
    return ForgotApiResponse.fromJson(response);
  }

  Future<EmailVerificationResponse> getOTPVerify(
    Map<String, String> body,
  ) async {
    final response = await _apiService.postRequest(
      "/api/verify-email-code",
      body: body,
    ); // API Endpoint
    return EmailVerificationResponse.fromJson(response);
  }

  Future<ResendCodeResponse> resendEmailCode(Map<String, String> body) async {
    final response = await _apiService.postRequest(
      "/api/resend-email-code",
      body: body,
    ); // API Endpoint
    return ResendCodeResponse.fromJson(response);
  }

  Future<ResendCodeResponse> resendPhoneCode(Map<String, String> body) async {
    final response = await _apiService.postRequest(
      "/api/resend-email-code-sms",
      body: body,
    ); // API Endpoint
    return ResendCodeResponse.fromJson(response);
  }

  Future<ResetApiResponse> resetPass(Map<String, String> body) async {
    final response = await _apiService.postRequest(
      "/api/verify-forget-otp",
      body: body,
    ); // API Endpoint
    return ResetApiResponse.fromJson(response);
  }
}
