import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/exceptions/app_exception.dart';
import '../../core/extension/future.dart';
import '../../domain/model/token.dart';
import '../../domain/repository/auth.dart';
import '../source/remote/auth.dart';

part 'auth.g.dart';

@riverpod
AuthRepository authRepo(AuthRepoRef ref) =>
    AuthRepositoryImpl(ref.read(authSourceProvider));

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._source);

  final AuthSource _source;

  @override
  Future<Either<AppException, Token>> generateToken({
    required String username,
    required String password,
  }) {
    final token = _source.generateToken(
      {'username': username, 'password': password},
    );
    return token.guardFuture();
  }

  @override
  Future<Either<AppException, Token>> refreshToken(String token) {
    return _source.refreshToken({'refreshToken': token}).guardFuture();
  }

  @override
  Future<Either<AppException, bool>> checkServerConnection() async {
    // TODO('Developer'): Call the api for checking the
    return right(true);
  }
}
