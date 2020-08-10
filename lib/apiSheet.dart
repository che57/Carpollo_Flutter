import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Api{
  Api._internal() {
    dio = new Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
    dio.options.baseUrl = 'https://backend.carpollo.com';
  }

  Dio dio;
  static final Api _instance = Api._internal();
  static Api get instance => _instance;
  factory Api() {
    return _instance;
  }

  Future<Response> signIn({@required String email, @required String password}) async {
    return dio.post(
      '/users/sign-in',
      data: {'email': email, 'password': password},
    );
  }

  Future<Response> getPosts() async {
    return dio.get(
      '/community/post',
    );
  }
}