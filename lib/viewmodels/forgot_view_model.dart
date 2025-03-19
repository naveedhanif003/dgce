import 'package:dream_al_emarat_app/apis_response/login_api_response/LoginApiResponse.dart';
import 'package:dream_al_emarat_app/apis_response/setting_api_response/SettingApiResponse.dart';
import 'package:flutter/material.dart';
import '../apis_response/forgot_api_response/ForgotApiResponse.dart';
import '../core/utils/helpers/status.dart';
import '../repository/AppRepository.dart';

class ForgotViewModel extends ChangeNotifier {
  final AppRepository _repository = AppRepository();

  Status _status = Status.IDLE;
  ForgotApiResponse? _forgotResponse;
  String? _errorMessage;

  Status get status => _status;
  ForgotApiResponse? get forgot => _forgotResponse;
  String? get errorMessage => _errorMessage;

  /// Fetch Forgot API
  Future<void> fetchForgot(Map<String, String> forgot) async {
    _status = Status.LOADING;
     notifyListeners();

    try {
      _forgotResponse = await _repository.getForgotPass(forgot);
      print("exeception $_forgotResponse");
      _status = Status.COMPLETE;
    } catch (e) {
      _errorMessage = e.toString();
      _status = Status.ERROR;
    }

    notifyListeners();
  }
}
