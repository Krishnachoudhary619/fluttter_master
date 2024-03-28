import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../../core/extension/context.dart';
import '../shared/components/app_text_theme.dart';
import '../theme/config/app_color.dart';
import 'components/notification_list.dart';
import 'provider/notification_list_notifier.dart';

@RoutePage()
class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationPageState();
}

final linkProvider = StateProvider<bool>((ref) {
  return false;
});

class _NotificationPageState extends ConsumerState<NotificationPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(notificationListNotifierProvider.notifier).reset();
      // ref.read(transactionListNotifierProvider.notifier).getTransactionList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final notificationState = ref.watch(notificationHistoryProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref
            .read(
              notificationListNotifierProvider.notifier,
            )
            .reset();
        // await ref
        //     .read(NotificationListNotifierProvider.notifier)
        //     .getTransactionList();
      },
      child: Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          elevation: 0,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Gap(40),
                  Text(
                    'Notifications',
                    style:
                        AppTextTheme.semiBold20.copyWith(color: AppColor.white),
                  ),
                ],
              ),
            ],
          ),
          leadingWidth: context.width,
        ),
        body: const SingleChildScrollView(
          child: Column(
            children: [
              Gap(20),
              NotificationList(),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
