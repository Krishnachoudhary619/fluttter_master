import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';

import '../../../domain/model/token.dart';
import '../../helper/pref_keys.dart';

part 'shar_pref.g.dart';

@riverpod
SharPrefRepo sharedPref(SharedPrefRef ref) =>
    SharPrefImpl(ref.read(secureSharedPrefProvider));

@riverpod
SecureSharedPref secureSharedPref(SecureSharedPrefRef ref) => throw Exception();

abstract class SharPrefRepo {
  Future<void> saveToken(Token token);
  Future<Token?> getToken();
  Future<void> clearAll();
}

class SharPrefImpl extends SharPrefRepo {
  SharPrefImpl(this._pref);

  final SecureSharedPref _pref;

  @override
  Future<void> saveToken(Token token) async {
    await _pref.putString(PrefKeys.token, jsonEncode(token));
  }

  @override
  Future<Token?> getToken() async {
    final encoded = await _pref.getString(PrefKeys.token) ?? '';
    if (encoded.isEmpty) {
      return null;
    }
    return Token.fromJson(jsonDecode(encoded) as Map<String, dynamic>);
  }

  @override
  Future<void> clearAll() async {
    await _pref.clearAll();
  }
}
