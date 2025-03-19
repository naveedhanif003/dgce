/// user_id : 7
/// role_id : 3

class Pivot {
  Pivot({
      this.userId, 
      this.roleId,});

  Pivot.fromJson(dynamic json) {
    userId = json['user_id'];
    roleId = json['role_id'];
  }
  int? userId;
  int? roleId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['role_id'] = roleId;
    return map;
  }

}