/// nextUrl : "https://test.dhinvest.ae/password/reset"

class Data {
  Data({
      this.nextUrl,});

  Data.fromJson(dynamic json) {
    nextUrl = json['nextUrl'];
  }
  String? nextUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['nextUrl'] = nextUrl;
    return map;
  }

}