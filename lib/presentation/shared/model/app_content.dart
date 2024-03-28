import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_content.freezed.dart';
part 'app_content.g.dart';

@freezed
class AppContentModel with _$AppContentModel {
  const factory AppContentModel({
    @Default('') String appLogo,
    @Default('') String splash,
    @Default('') String androidAppId,
    @Default('') String iOSAppId,
    @Default(<Onboarding>[]) List<Onboarding> onboarding,
    @Default(HomeGreetings()) HomeGreetings homeGretting,
    @Default(SocialMediaLinks()) SocialMediaLinks socialMedia,
    @Default(Registration()) Registration registration,
  }) = _AppContentModel;

  factory AppContentModel.fromJson(Map<String, dynamic> json) =>
      _$AppContentModelFromJson(json);
}

@freezed
class Registration with _$Registration {
  const factory Registration({
    @Default('') String tnc,
  }) = _Registration;

  factory Registration.fromJson(Map<String, dynamic> json) =>
      _$RegistrationFromJson(json);
}

@freezed
class HomeGreetings with _$HomeGreetings {
  const factory HomeGreetings({
    @Default('') String goodMorning,
    @Default('') String goodAfternoon,
    @Default('') String goodEvening,
  }) = _HomeGreetings;

  factory HomeGreetings.fromJson(Map<String, dynamic> json) =>
      _$HomeGreetingsFromJson(json);
}

@freezed
class Onboarding with _$Onboarding {
  const factory Onboarding({
    @Default('') String title,
    @Default('') String subtitle,
    @Default('') String image,
  }) = _Onboarding;

  factory Onboarding.fromJson(Map<String, dynamic> json) =>
      _$OnboardingFromJson(json);
}

@freezed
class Support with _$Support {
  const factory Support({
    @Default('') String phone,
    @Default('') String gmail,
  }) = _Support;

  factory Support.fromJson(Map<String, dynamic> json) =>
      _$SupportFromJson(json);
}

@freezed
class SocialMediaLinks with _$SocialMediaLinks {
  const factory SocialMediaLinks({
    @Default(Support()) Support support,
    @Default('') String instagram,
    @Default('') String instagramUrlScheme,
    @Default('') String facebook,
    @Default('') String linkedin,
    @Default('') String twitter,
    @Default('') String aboutUs,
    @Default('') String termsAndCondition,
    @Default('') String rateUs,
    @Default('') String playStoreAppName,
  }) = _SocialMediaLinks;

  factory SocialMediaLinks.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaLinksFromJson(json);
}
