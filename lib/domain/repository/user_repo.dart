import 'package:dartz/dartz.dart';

import '../../core/exceptions/app_exception.dart';
import '../model/user.dart';

abstract class UserRepository {
  Future<Either<AppException, User>> getUserById(int id);
}
