import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_res.freezed.dart';
part 'api_res.g.dart';

@freezed
class ApiRes with _$ApiRes {
  const factory ApiRes({
    @Default('') String status,
    @Default('') String code,
    ErrorMsg? error,
    dynamic data,
  }) = _ApiRes;

  factory ApiRes.fromJson(Map<String, dynamic> json) => _$ApiResFromJson(json);
}

@freezed
class ErrorMsg with _$ErrorMsg {
  const factory ErrorMsg({
    String? message,
    String? type,
  }) = _ErrorMsg;

  factory ErrorMsg.fromJson(Map<String, dynamic> json) =>
      _$ErrorMsgFromJson(json);
}
