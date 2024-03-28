import 'package:freezed_annotation/freezed_annotation.dart';

part 'predefined.freezed.dart';
part 'predefined.g.dart';

@freezed
class Predefined with _$Predefined {
  const factory Predefined({
    @Default(-1) int predefinedId,
    @Default('') String name,
    @Default('') String entityType,
    @Default('') String entitySubType,
    @Default('') String url,
    @Default('') String code,
    @Default(false) bool checked,
  }) = _Predefined;

  factory Predefined.fromJson(Map<String, dynamic> json) =>
      _$PredefinedFromJson(json);
}
