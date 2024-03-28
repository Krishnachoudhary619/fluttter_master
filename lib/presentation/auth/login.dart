import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/token_provider.dart';
import '../routes/app_router.dart';
import '../shared/model/user_state.dart';
import '../shared/providers/router.dart';
import 'providers/login_notifier.dart';

@RoutePage()
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<LoginPage> {
  late ProviderSubscription _subscription;

  @override
  void initState() {
    super.initState();
    attachObserver();
  }

  void attachObserver() {
    _subscription =
        ref.listenManual<UserState<bool>>(loginNotifierProvider, (prev, next) {
      if (next.data) {
        ref.read(routerProvider).replace(const HomeRoute());
      }
    });
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(loginNotifierProvider.notifier);
    final state = ref.watch(loginNotifierProvider);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('$state'),
              if (state.data) Text('${ref.watch(tokenNotifierProvider)}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  context.pushRoute(const SecondRoute());
                },
                child: const Text('Second page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
