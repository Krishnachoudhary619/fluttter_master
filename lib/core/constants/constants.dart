import 'flavor.dart';

class Constants {
  Constants._({
    required this.flavor,
    required this.baseUrl,
  });

  static final Constants instance = Constants._(
    flavor: Flavor.values.firstWhere(
      (element) => element.name == const String.fromEnvironment('FLAVOR'),
    ),
    baseUrl: '${const String.fromEnvironment('BASE_URL')}:8080/',
  );

  final Flavor flavor;
  final String baseUrl;

  //Auth
  static const String generateToken = 'auth/generate-token';
  static const String refreshToken = 'auth/refresh-token';

  //User
  static const String getUserById = 'user/{id}';

  //Notification
  static const String updateFirebaseToken = 'fcm/token/save';
  static const String getNotificationList = 'fcm/notification/list';
  static const String getNotificationCount = 'fcm/notification/count';
  // static const String markAsRead = 'operator/readNotification';
}
