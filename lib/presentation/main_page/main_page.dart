// ignore_for_file: deprecated_member_use

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../routes/app_router.dart';
import '../shared/components/custom_dialog.dart';
import 'section/bottom_nav_bar.dart';

@RoutePage()
class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  Future<bool> _onWillPop() async {
    //Get TabsRouter
    // final tabsRouter = AutoTabsRouter.of(context);
    // if (tabsRouter.activeIndex != 0) {
    //   tabsRouter.setActiveIndex(0);
    //   return false;
    // }
    return (await showDialog(
          context: context,
          builder: (context) => CustomDialog(
            title: 'Are you sure?',
            description: 'Do you want to exit the App',
            // onPositive: () {
            //   ref.read(sharedPrefProvider).clearAll();
            //   ref.read(routerProvider).replaceAll(
            //     [const LoginRoute()],
            //   );
            // },
            onPositive: () => Navigator.of(context).pop(true),
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AutoTabsScaffold(
        routes: const [
          HomeRoute(),
          HomeRoute(),
          HomeRoute(),
          NotificationRoute(),
        ],
        bottomNavigationBuilder: (context, tabsRouter) => BottomNavBar(
          selected: tabsRouter.activeIndex,
          onTabChanged: tabsRouter.setActiveIndex,
        ),
      ),
    );
  }
}
