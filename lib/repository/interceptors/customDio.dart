import 'package:dio/dio.dart';

class AbstractRepository<T> {


  Response response;
  final Dio dio;

  AbstractRepository({this.response, this.dio});



}