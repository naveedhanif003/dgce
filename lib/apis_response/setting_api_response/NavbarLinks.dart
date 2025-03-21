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
    this.type,
  });

  NavbarLinks.fromJson(dynamic json) {
    slug = json['slug'] as String?;
    title = json['title'] as String?;
    link = json['link'] as String?;
    method = json['method'] as String?;
    type = json['type'] as String?;
  }

  String? slug;
  String? title;
  String? link;
  String? method;
  String? type;

  Map<String, dynamic> toJson() {
    return {
      if (slug != null) 'slug': slug,
      if (title != null) 'title': title,
      if (link != null) 'link': link,
      if (method != null) 'method': method,
      if (type != null) 'type': type,
    };
  }
}
