import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:projeto_forum_proeidi/repository/interceptors/interceptor.dart';

class CustomDIO extends DioForNative {
  CustomDIO([BaseOptions options]) : super(options) {
    interceptors.add(CustomInterceptor());
  }
}