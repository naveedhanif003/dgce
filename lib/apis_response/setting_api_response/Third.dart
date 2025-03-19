/// title : "Sell Gold with Ease"
/// description : ["Quickly liquidate your gold when you need to.","Get the best market rates, directly in the app.","Fast, secure payouts to your linked account."]

class Third {
  Third({
      this.title, 
      this.description,});

  Third.fromJson(dynamic json) {
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