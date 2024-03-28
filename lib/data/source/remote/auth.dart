import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../../../domain/model/token.dart';
import '../../helper/dio_instance.dart';

part 'auth.g.dart';

@riverpod
AuthSource authSource(AuthSourceRef ref) =>
    AuthSource(ref.watch(dioInstanceProvider));

@RestApi()
abstract class AuthSource {
  factory AuthSource(Dio _dio) => _AuthSource(_dio);

  @POST(Constants.generateToken)
  Future<Token> generateToken(@Body() Map<String, String> body);

  @POST(Constants.refreshToken)
  Future<Token> refreshToken(@Body() Map<String, String> body);
}
