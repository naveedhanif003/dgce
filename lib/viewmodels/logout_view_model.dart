import 'package:dream_al_emarat_app/apis_response/login_api_response/LoginApiResponse.dart';
import 'package:dream_al_emarat_app/apis_response/logout_response/LogoutResponse.dart';
import 'package:dream_al_emarat_app/apis_response/setting_api_response/SettingApiResponse.dart';
import 'package:flutter/material.dart';
import '../core/utils/helpers/status.dart';
import '../repository/AppRepository.dart';

class LogoutViewModel extends ChangeNotifier {
  final AppRepository _repository = AppRepository();

  Status _status = Status.IDLE;
  LogoutResponse? _logoutResponse;
  String? _errorMessage;

  Status get status => _status;
  LogoutResponse? get login => _logoutResponse;
  String? get errorMessage => _errorMessage;

  /// Fetch Settings API
  Future<void> fetchLogout(Map<String, String> logout) async {
    _status = Status.LOADING;
     notifyListeners();

    try {
      _logoutResponse = await _repository.getLogout(logout);
      _status = Status.COMPLETE;
    } catch (e) {
      _errorMessage = e.toString();
      _status = Status.ERROR;
    }

    notifyListeners();
  }
}
