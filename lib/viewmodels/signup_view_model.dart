import 'package:dream_al_emarat_app/apis_response/login_api_response/LoginApiResponse.dart';
import 'package:dream_al_emarat_app/apis_response/setting_api_response/SettingApiResponse.dart';
import 'package:flutter/material.dart';
import '../apis_response/signup_api_response/SignupApiResponse.dart';
import '../core/utils/helpers/status.dart';
import '../repository/AppRepository.dart';

class SignUpViewModel extends ChangeNotifier {
  final AppRepository _repository = AppRepository();

  Status _status = Status.IDLE;
  SignupApiResponse? _signupResponse;
  String? _errorMessage;

  Status get status => _status;
  SignupApiResponse? get signup => _signupResponse;
  String? get errorMessage => _errorMessage;

  /// Fetch Settings API
  Future<void> fetchSignup(Map<String, String> signup) async {
    _status = Status.LOADING;
     notifyListeners();

    try {
      _signupResponse = await _repository.getSignup(signup);
      _status = Status.COMPLETE;
    } catch (e) {
      _errorMessage = e.toString();
      _status = Status.ERROR;
    }

    notifyListeners();
  }
}
