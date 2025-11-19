import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;

class AppConfig {
  // Toggle this to switch between production and local emulator quickly
  static const bool useProduction = false;

  static const String prodBase =
      'https://rayyan-akbar-footballshop.pbp.cs.ui.ac.id';
  static const String localWebBase = 'http://localhost:8000';
  static const String localAndroidBase = 'http://10.0.2.2:8000';

  static String get base {
    if (useProduction) return prodBase;
    if (kIsWeb) return localWebBase;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return localAndroidBase;
      default:
        return localWebBase;
    }
  }

  static String get authLogin => '$base/auth/login/';
  static String get authRegister => '$base/auth/register/';
  static String get authLogout => '$base/auth/logout/';
  static String get addProductAjax => '$base/add-product-ajax/';

  static String jsonProducts({bool myItems = false}) =>
      myItems ? '$base/json/?filter=my_items' : '$base/json/';

  static String proxyImage(String absoluteUrl) =>
      '$base/proxy-image/?url=${Uri.encodeComponent(absoluteUrl)}';

  static String absolutize(String url) =>
      url.startsWith('http') ? url : '$base$url';
}
