import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/services/notification_manager.dart';
import '../../core/services/push_notification.dart';
import '../../core/services/remote_config.dart';
import '../../core/utils/app_utils.dart';
import '../../data/repository/notification_repo_impl.dart';
import '../routes/app_router.dart';
import '../shared/providers/app_content.dart';
import '../shared/providers/router.dart';

@RoutePage()
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(remoteConfigProvider).init();
      await Future.delayed(const Duration(milliseconds: 200));
      await ref.read(appContentProvider.notifier).updateState();
      ref.refresh(notificationManagerProvider);
      ref.refresh(pushNotificationProvider);

      final firebaseToken =
          await ref.read(notificationRepoProvider).getFirebaseToken();

      try {
        if (!await checkUpdate()) {
          _timer = Timer(
            const Duration(seconds: 2),
            () => ref.read(routerProvider).replace(const MainRoute()),
          );
        }
      } catch (e) {
        if (e is String) {
          AppUtils.snackBar(context, 'Error', e);
        } else {
          AppUtils.snackBar(context, 'Error', 'Something went wrong');
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(appContentProvider);
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Placeholder(),
        ),
      ),
    );
  }

  Future<bool> checkUpdate() async {
    try {
      if (Platform.isAndroid) {
        //Check android update
        final update = await InAppUpdate.checkForUpdate();
        if (update.updateAvailability == UpdateAvailability.updateAvailable) {
          await InAppUpdate.performImmediateUpdate();
          return true;
        }
      }
      if (Platform.isIOS) {
        final version = (await PackageInfo.fromPlatform()).version;

        final latestVersion = ref
            .read(remoteConfigProvider)
            .getString(RemoteConfigKeys.latestVersionIOS);

        final checkUpdate = ref
            .read(remoteConfigProvider)
            .getBool(RemoteConfigKeys.checkUpdate);

        if (checkUpdate && version != latestVersion) {
          //Show Alert
          // ignore: use_build_context_synchronously
          context.replaceRoute(const UpdateRoute());
          return true;
        }

        return false;
      }
    } catch (e) {}
    return false;
  }
}
