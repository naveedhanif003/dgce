/// slug : "contact_us"
/// title : "Contact Us"
/// link : "https://test.dhinvest.ae/contact-us?is_httpClient=1"
/// method : "get"
/// type : "web_view"

class NavbarLinks {
  NavbarLinks({
      this.slug, 
      this.title, 
      this.link, 
      this.method, 
      this.type,});

  NavbarLinks.fromJson(dynamic json) {
    slug = json['slug'];
    title = json['title'];
    link = json['link'];
    method = json['method'];
    type = json['type'];
  }
  String? slug;
  String? title;
  String? link;
  String? method;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slug'] = slug;
    map['title'] = title;
    map['link'] = link;
    map['method'] = method;
    map['type'] = type;
    return map;
  }

}