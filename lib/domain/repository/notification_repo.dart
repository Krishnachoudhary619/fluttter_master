import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../core/exceptions/app_exception.dart';
import '../model/notification_model.dart';

abstract class NotificationRepository {
  Future<String?> getFirebaseToken();
  Stream<RemoteMessage> get onForegroundPushNotification;
  Stream<RemoteMessage> get onBackgroundPushNotification;
  Stream<String> get onTokenExpired;

  Future<void> saveFirebaseToken({
    required int userId,
    required String token,
    required String deviceType,
  });
  Future<Either<AppException, List<Notifications>>> getNotification(
    int pageNumber,
    int pageSize,
    int userId,
  );

  // Future<Either<AppException, NotificationReadCountRes>>
  //     getNotificationUnreadCount(int userId);

  // Future<Either<AppException, NotificationCountRes>> getNotificationUnreadCount(
  //   int userId,
  // );
  // Future<Either<AppException, VerifyOtpRes>> markAsRead();
}
