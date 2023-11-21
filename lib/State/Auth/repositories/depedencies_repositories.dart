import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DependenciesRepositories {
  final Dio _dio;

  DependenciesRepositories({@required dio})
      : _dio = dio,
        assert(dio != null);

  Dio get dio => _dio;
}
