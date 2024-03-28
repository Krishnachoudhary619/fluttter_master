import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/constants/constants.dart';
import '../../../domain/model/user.dart';
import '../../helper/dio_instance.dart';

part 'user_source.g.dart';

@riverpod
UserSource userSource(UserSourceRef ref) =>
    UserSource(ref.watch(dioInstanceProvider));

@RestApi()
abstract class UserSource {
  factory UserSource(Dio _dio) => _UserSource(_dio);

  @GET(Constants.getUserById)
  Future<User> getUserById(@Path() int id);
}
