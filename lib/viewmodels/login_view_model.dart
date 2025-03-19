import 'package:dream_al_emarat_app/apis_response/login_api_response/LoginApiResponse.dart';
import 'package:dream_al_emarat_app/apis_response/setting_api_response/SettingApiResponse.dart';
import 'package:flutter/material.dart';
import '../core/utils/helpers/status.dart';
import '../repository/AppRepository.dart';

class LoginViewModel extends ChangeNotifier {
  final AppRepository _repository = AppRepository();

  Status _status = Status.IDLE;
  LoginApiResponse? _loginResponse;
  String? _errorMessage;

  Status get status => _status;
  LoginApiResponse? get login => _loginResponse;
  String? get errorMessage => _errorMessage;

  /// Fetch Settings API
  Future<void> fetchLogin(Map<String, String> login) async {
    _status = Status.LOADING;
     notifyListeners();

    try {
      _loginResponse = await _repository.getLogin(login);
      _status = Status.COMPLETE;
    } catch (e) {
      _errorMessage = e.toString();
      _status = Status.ERROR;
    }

    notifyListeners();
  }
}
