class SettingModel {
  final String fcm_token;
  final String user_type;
  final String fcm_token_type;
  final String access_token;

  SettingModel({required this.fcm_token, required this.user_type, required this.fcm_token_type, required this.access_token});

  // Convert JSON to UserModel
  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      fcm_token: json['fcm_token'],
      user_type: json['user_type'],
      fcm_token_type: json['fcm_token_type'],
      access_token: json['access_token'],
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      "fcm_token": fcm_token,
      "user_type": user_type,
      "fcm_token_type": fcm_token_type,
      "access_token": access_token,
    };
  }
}
