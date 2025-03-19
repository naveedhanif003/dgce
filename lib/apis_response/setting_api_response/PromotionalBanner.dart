/// found : false
/// banner_url : null
/// redirect_url : null

class PromotionalBanner {
  PromotionalBanner({
      this.found, 
      this.bannerUrl, 
      this.redirectUrl,});

  PromotionalBanner.fromJson(dynamic json) {
    found = json['found'];
    bannerUrl = json['banner_url'];
    redirectUrl = json['redirect_url'];
  }
  bool? found;
  dynamic bannerUrl;
  dynamic redirectUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['found'] = found;
    map['banner_url'] = bannerUrl;
    map['redirect_url'] = redirectUrl;
    return map;
  }

}