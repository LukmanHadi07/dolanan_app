import 'package:dio/dio.dart';
import 'package:dulinan/src/shared/data/remote/dio_network_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkServiceProvider = Provider<DioNetworkService>((ref) {
  final Dio _dio = Dio();
  return DioNetworkService(_dio, ref);
});
