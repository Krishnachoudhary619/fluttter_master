import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../core/extension/widget.dart';
import '../../shared/components/app_text_theme.dart';
import '../../shared/gen/assets.gen.dart';
import '../../theme/app_style.dart';
import '../../theme/config/app_color.dart';

class NotificationTile extends ConsumerStatefulWidget {
  const NotificationTile({
    super.key,
    // required this.title,
    // required this.createdDate,
    // required this.message,
  });
  // final String title;
  // final String createdDate;
  // final String message;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationTileState();
}

class _NotificationTileState extends ConsumerState<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: AppStyle.shadow,
        color: AppColor.white,
        border: Border.all(
          color: AppColor.white.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColor.primary,
              child: Assets.icons.logo.image(height: 20, width: 20),
            ),
          ),
          const Gap(10),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title', style: AppTextTheme.semiBold14),
                Text(
                  ('Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum'
                              .length >
                          70)
                      ? '${'Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum'.substring(0, 70)}...'
                      : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit Lorem ipsum',
                  style: AppTextTheme.label12.copyWith(color: AppColor.grey),
                  // overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
          const Gap(10),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '23/12/2023',
                  // (widget.createdDate != '')
                  //     ? changeToSimpleDMY(widget.createdDate)
                  //     : '',
                  style: AppTextTheme.label12,
                ),
                Text(
                  '2:45 PM',
                  // (widget.createdDate != '')
                  //     ? changeToSimpleDMY(widget.createdDate)
                  //     : '',
                  style: AppTextTheme.label12,
                ),
              ],
            ),
          ),
        ],
      ).padAll(10),
    ).pad(left: 20, right: 20, bottom: 20);
  }
}
