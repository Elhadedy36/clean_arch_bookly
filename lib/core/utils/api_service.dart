
import 'package:dio/dio.dart';

class ApiService 
{
  final Dio _dio;
  final baseurl = 'https://www.googleapis.com/books/v1/';//part of the request but constant on all
  ApiService(this._dio); 

 Future<Map<String,dynamic>> get({required String endPoint})async
  {
    var response = await _dio.get('$baseurl$endPoint');
    return response.data;
  }
}