import 'package:dream_al_emarat_app/apis_response/login_api_response/LoginApiResponse.dart';
import 'package:dream_al_emarat_app/apis_response/reset_api_response/ResetApiResponse.dart';
import 'package:dream_al_emarat_app/apis_response/setting_api_response/SettingApiResponse.dart';
import 'package:flutter/material.dart';
import '../core/utils/helpers/status.dart';
import '../repository/AppRepository.dart';

class ResetViewModel extends ChangeNotifier {
  final AppRepository _repository = AppRepository();

  Status _status = Status.IDLE;
  ResetApiResponse? _resetApiResponse;
  String? _errorMessage;

  Status get status => _status;
  ResetApiResponse? get reset => _resetApiResponse;
  String? get errorMessage => _errorMessage;

  /// Fetch Settings API
  Future<void> resetPass(Map<String, String> body) async {
    _status = Status.LOADING;
     notifyListeners();

    try {
      _resetApiResponse = await _repository.resetPass(body);
      _status = Status.COMPLETE;
    } catch (e) {
      _errorMessage = e.toString();
      _status = Status.ERROR;
    }

    notifyListeners();
  }
}
