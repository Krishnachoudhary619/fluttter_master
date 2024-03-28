import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../data/repository/user_repo.dart';
import '../../../domain/model/user.dart';
import '../../../domain/repository/user_repo.dart';
import '../../shared/model/user_state.dart';

part 'home_notifier.g.dart';

@riverpod
class HomeNotifier extends _$HomeNotifier {
  late UserRepository _repo;

  @override
  UserState<User> build() {
    _repo = ref.read(userRepoProvider);
    return UserState(data: const User());
  }

  Future<void> getUser() async {
    state = state.copyWith(loading: true);
    (await _repo.getUserById(1)).fold(onError, onResult);
  }

  void onError(AppException error) {
    state = state.copyWith(error: error.message, loading: false);
  }

  void onResult(User result) {
    state = state.copyWith(data: result, loading: false);
  }
}
