/// title : "Buy Gold Instantly"
/// description : ["Purchase digital gold with just a few taps.","Real-time pricing and secure transactions, always.","Diversify your portfolio, right from your phone."]

class Second {
  Second({
      this.title, 
      this.description,});

  Second.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'] != null ? json['description'].cast<String>() : [];
  }
  String? title;
  List<String>? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    return map;
  }

}