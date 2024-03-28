// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/api_res.dart';
import '../../presentation/shared/components/app_text_theme.dart';
import '../../presentation/theme/config/app_color.dart';
import '../exceptions/app_exception.dart';
import '../extension/widget.dart';

class AppUtils {
  static Either<DioError, Object?> checkError(
    dynamic data,
    RequestOptions requestOptions,
  ) {
    if (data is! Map<String, dynamic> || data is List) {
      return right(
        ApiRes(
          data: data,
        ).data,
      );
    }
    final apiRes = ApiRes.fromJson(data);
    if (apiRes.error?.message?.isEmpty == true) {
      return left(
        DioError(
          requestOptions: requestOptions,
          error: AppException(
            message: apiRes.error?.message ?? '',
            type: ErrorType.responseError,
          ),
        ),
      );
    }
    if (apiRes.data != null) {
      return right(apiRes.data);
    }
    return right(data);
  }

  static dynamic convertDataToMap(dynamic data) {
    final temp = <String, dynamic>{};
    if (data == null) {
      return temp;
    }
    if (data is String) {
      if (data.contains('{')) {
        return jsonDecode(data);
      }
      return temp..['data'] = data;
    }
    if (data is Map<String, dynamic>) {
      if (data.containsKey('data')) {
        return data['data'];
      }
      temp.addAll(data);
    }
    if (temp.isEmpty) {
      return data;
    }
    return temp;
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    BuildContext contextt,
    String title,
    String message, {
    Color color = AppColor.primary,
  }) {
    return ScaffoldMessenger.of(contextt).showSnackBar(
      SnackBar(
        backgroundColor: color,
        margin: const EdgeInsets.all(8.0),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: AppTextTheme.semiBold14,
            ),
            Text(
              message,
              style: AppTextTheme.label12,
            ).padAll(10),
          ],
        ),
      ),
    );
  }

  static Future<void> launchUrlExternal(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> lauchStore({
    required String playStoreAppId,
    required String iosId,
  }) async {
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? playStoreAppId : iosId;
      final url = Uri.parse(
        Platform.isAndroid
            ? 'https://play.google.com/store/apps/details?id=$appId'
            : 'https://apps.apple.com/app/id$appId',
      );

      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }
}
