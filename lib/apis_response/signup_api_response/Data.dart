/// access_token : "UXdjblZ5QkoxL25LNUxuRGtQSDdHcTdjVStHQzd4WGhOTG01eFp3bXJqa1FZTnBiYWNtZXNXT0JlOUIwUy9CZ1Q3NkQ0S05OYTYrSGptWUlhcVlWMHc9PQ=="

class Data {
  Data({
      String? accessToken,}){
    _accessToken = accessToken;
}

  Data.fromJson(dynamic json) {
    _accessToken = json['access_token'];
  }
  String? _accessToken;
Data copyWith({  String? accessToken,
}) => Data(  accessToken: accessToken ?? _accessToken,
);
  String? get accessToken => _accessToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    return map;
  }

}