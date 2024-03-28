import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/notification_list_notifier.dart';
import 'notification_tile.dart';

class NotificationList extends ConsumerStatefulWidget {
  const NotificationList({
    super.key,
  });
  @override
  ConsumerState<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends ConsumerState<NotificationList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(notificationListNotifierProvider);

    // if (result.data.isEmpty)
    //   return RefreshIndicator(
    //     onRefresh: () async {
    //       ref
    //           .read(
    //             notificationListNotifierProvider.notifier,
    //           )
    //           .reset();
    //       // await ref
    //       //     .read(notificationListNotifierProvider.notifier)
    //       //     .getNotificationList();
    //     },
    //     child: SizedBox(
    //       height: context.heightByPercent(70),
    //       child: Center(
    //         child: Text(
    //           'No Services yet',
    //           style: AppTextTheme.label14,
    //         ),
    //       ),
    //     ),
    //   );

    // if (!result.loading && result.data.isNotEmpty)
    return RefreshIndicator(
      onRefresh: () async {
        ref
            .read(
              notificationListNotifierProvider.notifier,
            )
            .reset();
        // await ref
        // .read(
        //   notificationListNotifierProvider.notifier,
        // )
        // .getNotificationList();
      },
      child: ListView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          // if (result.data.length - 1 == index && result.loadMore) {
          //   ref
          //       .read(
          //         notificationListNotifierProvider.notifier,
          //       )
          //       .loadMore();
          //   return const AppLoader();
          // }
          // if (result.data[index].subscription.subscriptionId == 0) {
          //   return const SizedBox();
          // }

          return const NotificationTile();
        },
        itemCount: 13,
      ),
    );
    // else
    //   return const AppLoader();
  }
}
