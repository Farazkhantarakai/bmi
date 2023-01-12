import 'dart:io';

class AdHelper {
  static String homePageBanner() {
    if (Platform.isAndroid) {
      return "ca-app-pub-5769137860547781/7223898919";
    } else {
      return "";
    }
  }

  static String resultInterstetialPage() {
    if (Platform.isAndroid) {
      return "ca-app-pub-5769137860547781/4091889994";
    } else {
      return "";
    }
  }
}
