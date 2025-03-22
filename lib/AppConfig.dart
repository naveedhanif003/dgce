enum Flavor {staging,production}

class AppConfig{
  static Flavor appFlavor  = Flavor.staging;

  static String get baseUrl{
    switch (appFlavor){
      case Flavor.staging: return "https://test.dhinvest.ae";
      case Flavor.production: return "https://dgce.co";
    }
  }
}