import 'package:dream_al_emarat_app/apis_response/setting_api_response/SettingApiResponse.dart';
import 'package:flutter/material.dart';
import '../core/utils/helpers/status.dart';
import '../repository/AppRepository.dart';

class SettingsViewModel extends ChangeNotifier {
  final AppRepository _repository = AppRepository();

  Status _status = Status.LOADING;
  SettingApiResponse? _settingsResponse;
  String? _errorMessage;

  Status get status => _status;
  SettingApiResponse? get settings => _settingsResponse;
  String? get errorMessage => _errorMessage;

  /// Fetch Settings API
  Future<void> fetchSettings(Map<String, String> setting_params) async {
    _status = Status.LOADING;
    // notifyListeners();

    try {
      _settingsResponse = await _repository.getSettings(setting_params);
      _status = Status.COMPLETE;
    } catch (e) {
      _errorMessage = e.toString();
      _status = Status.ERROR;
    }

    notifyListeners();
  }
}
