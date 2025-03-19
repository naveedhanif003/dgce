/// title : "Register your DGCE Account Today"
/// description : ["Tap to create your free account in seconds.","Securely access digital gold trading on the go.","Join thousands already building their wealth."]

class First {
  First({
      this.title, 
      this.description,});

  First.fromJson(dynamic json) {
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