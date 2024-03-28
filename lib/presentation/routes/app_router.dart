import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/remote_config/update_page.dart';
import '../auth/login.dart';
import '../home/home.dart';
import '../internet_connectivity/no_internet_page.dart';
import '../main_page/main_page.dart';
import '../notifications/notification_page.dart';
import '../splash/splash.dart';
import '../test_pages/second_page.dart';
import 'guard/auth_guard.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  AppRouter(this._ref);

  final Ref _ref;
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: NoInternetRoute.page),
        AutoRoute(page: SecondRoute.page),
        AutoRoute(page: UpdateRoute.page),
        AutoRoute(
          page: MainRoute.page,
          children: [
            AutoRoute(
              page: HomeRoute.page,
            ),
            AutoRoute(
              page: HomeRoute.page,
            ),
            AutoRoute(
              page: HomeRoute.page,
            ),
            AutoRoute(
              page: NotificationRoute.page,
            ),
          ],
        ),
        AutoRoute(
          page: HomeRoute.page,
          guards: [AuthGuard(_ref)],
        ),
      ];
}
