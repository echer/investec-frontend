class JsonUtils {
  static double parseDouble(dynamic data) {
    String str = data?.toString() ?? "0";
    double num = double.parse(str);
    return num;
  }

  static int parseInt(dynamic data, {bool floor = true}) {
    double core = parseDouble(data);
    return floor ? core.floor() : core.ceil();
  }

  static String parseString(dynamic data) {
    String str = data?.toString() ?? "";
    return str;
  }
}
