import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/providers/token_provider.dart';
import '../../../data/repository/auth.dart';
import '../../../domain/model/token.dart';
import '../../../domain/repository/auth.dart';
import '../../shared/model/user_state.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  late AuthRepository _repo;

  @override
  UserState<bool> build() {
    _repo = ref.read(authRepoProvider);
    return UserState(data: false);
  }

  Future<void> login() async {
    final result =
        await _repo.generateToken(username: 'admin', password: 'admin');
    result.fold(onError, onResult);
  }

  void onError(AppException error) {
    state = state.copyWith(error: error.message, loading: false);
  }

  Future<void> onResult(Token result) async {
    await ref.refresh(tokenNotifierProvider.notifier).updateToken(result);
    state = state.copyWith(data: true, loading: false);
  }
}
