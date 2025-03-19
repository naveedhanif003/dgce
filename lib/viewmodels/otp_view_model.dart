import 'package:dream_al_emarat_app/apis_response/email_verification_api_response/EmailVerificationResponse.dart';
import 'package:dream_al_emarat_app/apis_response/login_api_response/LoginApiResponse.dart';
import 'package:dream_al_emarat_app/apis_response/resend_email_code/ResendCodeResponse.dart';
import 'package:dream_al_emarat_app/apis_response/setting_api_response/SettingApiResponse.dart';
import 'package:flutter/material.dart';
import '../core/utils/helpers/status.dart';
import '../repository/AppRepository.dart';

class OTPViewModel extends ChangeNotifier {
  final AppRepository _repository = AppRepository();

  Status _status = Status.IDLE;
  EmailVerificationResponse? _otpResponse;
  ResendCodeResponse? _resendCodeResponse;
  String? _errorMessage;

  Status get status => _status;
  EmailVerificationResponse? get otp => _otpResponse;
  ResendCodeResponse? get resend => _resendCodeResponse;
  String? get errorMessage => _errorMessage;

  /// Fetch Settings API
  Future<void> otpVerify(Map<String, String> body) async {
    _status = Status.LOADING;
     notifyListeners();

    try {
      _otpResponse = await _repository.getOTPVerify(body);
      _status = Status.COMPLETE;
    } catch (e) {
      _errorMessage = e.toString();
      _status = Status.ERROR;
    }

    notifyListeners();
  }

  Future<void> resendEmailCode(Map<String, String> body) async {
    _status = Status.LOADING;
    notifyListeners();

    try {
      _resendCodeResponse = await _repository.resendEmailCode(body);
      _status = Status.COMPLETE;
    } catch (e) {
      _errorMessage = e.toString();
      _status = Status.ERROR;
    }

    notifyListeners();
  }

  Future<void> resendPhoneCode(Map<String, String> body) async {
    _status = Status.LOADING;
    notifyListeners();

    try {
      _resendCodeResponse = await _repository.resendPhoneCode(body);
      _status = Status.COMPLETE;
    } catch (e) {
      _errorMessage = e.toString();
      _status = Status.ERROR;
    }

    notifyListeners();
  }
}
