/// title : "Daily Profit Potential"
/// description : ["Monitor market trends and seize opportunities.","Track your earnings with clear, intuitive charts.","Experience the convenience of growing your wealth daily."]

class Fourth {
  Fourth({
      this.title, 
      this.description,});

  Fourth.fromJson(dynamic json) {
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