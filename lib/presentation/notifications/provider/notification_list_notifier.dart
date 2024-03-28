import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../core/exceptions/app_exception.dart';
import '../../../core/utils/debounce.dart';
import '../../../domain/model/notification_model.dart';
import '../../../domain/model/pagination_state_model.dart';

final notificationListNotifierProvider = StateNotifierProvider<
    NotificationListNotifier, PaginationState<List<Notifications>>>((
  ref,
) {
  return NotificationListNotifier(
    ref,
  );
});

class NotificationListNotifier
    extends StateNotifier<PaginationState<List<Notifications>>> {
  NotificationListNotifier(
    this._ref,
  ) : super(
          PaginationState(
            data: <Notifications>[],
          ),
        ) {
    init();
    reset();
    // getNotificationList();
  }

  final Ref _ref;
  // late SubscriptionRepo _repo;

  final searchCtrl = TextEditingController();
  final debounce = Debounce(millisecond: 1000);

  void init() {
    // _repo = _ref.read(subscriptionRepoProvider);
    searchCtrl.addListener(onSearch);
  }

  @override
  void dispose() {
    searchCtrl.removeListener(onSearch);
    debounce.dispose();
    super.dispose();
  }

  // Future<void> getNotificationList() async {
  //   final result = await _repo.getNotificationList(
  //     tradeUserId: _ref.read(registerNotifierProvider).Notifications.tradeUserId,
  //     pageNumber: state.page,
  //     pageSize: state.pageSize,
  //     searchValue: state.filter.searchBy,
  //   );
  //   result.fold(onException, (result) {
  //     state = state.copyWith(
  //       data: [...state.data, ...result],
  //       loadMore: result.length == state.pageSize,
  //       error: '',
  //       loading: false,
  //       page: state.page + 1,
  //     );
  //   });
  // }

  void onData(List<Notifications> result) {
    state = state.copyWith(
      data: [...state.data, ...result],
      loadMore: result.length == state.pageSize,
      error: '',
      loading: false,
      pageNumber: state.pageNumber + 1,
    );
  }

  void onException(AppException error) {
    state = state.copyWith(error: error.message, loading: false);
  }

  void onSearch() {
    debounce.run(() {
      state = state.copyWith(
        filter: state.filter.copyWith(searchBy: searchCtrl.text.trim()),
      );
      reset();
      // getNotificationList();
    });
  }

  Future<void> loadMore() async {
    if (state.loadMore) {
      // await getNotificationList();
    }
  }

  void reset() {
    state = PaginationState(data: <Notifications>[], filter: state.filter);
  }

  void clearList() {
    state = PaginationState(
      data: <Notifications>[],
      filter: state.filter.copyWith(
        startDateFilter: '',
        endDateFilter: '',
      ),
    );
  }

  void toggleStatus() {
    reset();
    state = state.copyWith(
      filter: state.filter.copyWith(
        isDeactivate: state.filter.isDeactivate == 'Y' ? 'N' : 'Y',
      ),
    );
    // getNotificationList();
  }
}
