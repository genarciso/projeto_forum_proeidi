
import 'package:dio/dio.dart';
import 'package:flutter_session/flutter_session.dart';

class CustomInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var tokenSessao = await FlutterSession().get("token");
    if (tokenSessao != null && tokenSessao != "") {
      var headerAuth = "Bearer $tokenSessao";
      options.headers["Authorization"] = headerAuth;
    }
    super.onRequest(options, handler);
  }
}