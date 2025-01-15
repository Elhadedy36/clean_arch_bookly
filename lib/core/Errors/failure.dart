import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class Failure {
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          message: 'Connection timeout with ApiServer',
        );

      case DioExceptionType.sendTimeout:
        return ServerFailure(
          message: 'Send timeout with ApiServer',
        );

      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          message: 'Receive timeout with ApiServer',
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(
          message: 'Bad certificate with ApiServer',
        );

      case DioExceptionType.badResponse:

        return  ServerFailure.fromResponse(dioError.response!.statusCode!, dioError.response!);
        
        

      case DioExceptionType.cancel:
        return ServerFailure(
          message: 'Request cancelled with ApiServer',
        );

      case DioExceptionType.connectionError:
        return ServerFailure(
          message: 'Connection error with ApiServer',
        );

      case DioExceptionType.unknown:
        return ServerFailure(
          message: 'Unknown error with ApiServer',
        );
    }
  }
  factory ServerFailure.fromResponse(int statusCode,dynamic response) 
  {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(message: response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure(message: 'Not Found');
    } else if (statusCode == 500) {
      return ServerFailure(message: 'Internal Server Error');
    } else if (statusCode == 502) {
      return ServerFailure(message: 'Bad Gateway');
    } else if (statusCode == 503) {
      return ServerFailure(message: 'Service Unavailable');
    } else { 
      return ServerFailure(message: 'Opps there was an error');
    }
  }
}
