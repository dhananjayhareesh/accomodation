import 'package:accomodation_admin/utils/enum.dart';

class BaseUrl {
  static AppBuild buildType = AppBuild.dev;
  static String developmentUrl = "http://127.0.0.1:5000/";
  static String ipAddress = "192.168.1.5";
  static String port = "5000";

  static get baseUrl {
    return buildType == AppBuild.dev
        ? "http://$ipAddress:$port/"
        : developmentUrl;
  }
}

class ApiConstants {
  static final baseUrl = BaseUrl.baseUrl;
  static const _user = "api/";
  static String refreshToken = "";
  static String suLogin = "${_user}auth/login";
  static const String asramCreate = "${_user}ashram"; // POST
  static const String asramList =
      "${_user}ashram"; // GET (same path as per your note)
  static const String roomCatCreate = "${_user}room-category"; // POST
  static const String roomCatList = "${_user}/room-category"; //get
// static get createItmmService => "$_baseUrl$_bom$_project";
}
