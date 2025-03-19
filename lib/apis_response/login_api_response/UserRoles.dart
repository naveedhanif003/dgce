import 'Pivot.dart';

/// id : 3
/// name : "Customer"
/// slug : "customer"
/// created_at : "2025-02-26T07:37:52.000000Z"
/// updated_at : "2025-02-26T07:37:52.000000Z"
/// pivot : {"user_id":7,"role_id":3}

class UserRoles {
  UserRoles({
      this.id, 
      this.name, 
      this.slug, 
      this.createdAt, 
      this.updatedAt, 
      this.pivot,});

  UserRoles.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }
  int? id;
  String? name;
  String? slug;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (pivot != null) {
      map['pivot'] = pivot?.toJson();
    }
    return map;
  }

}