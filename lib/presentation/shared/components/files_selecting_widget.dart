// ignore_for_file: avoid_print, prefer_foreach

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constants/file_types.dart';
import '../../../core/extension/context.dart';
import '../../../core/utils/app_utils.dart';
import '../../theme/config/app_color.dart';
import '../providers/file_picking_provider.dart';
import 'custom_filled_button.dart';

final getFileNameProvider = StateProvider<String>((ref) {
  return '';
});

class UploadWidget extends ConsumerStatefulWidget {
  const UploadWidget({
    Key? key,
    required this.filePathCtrl,
    required this.allowedExtensions,
  }) : super(key: key);
  final TextEditingController filePathCtrl;
  final List<String> allowedExtensions;

  @override
  ConsumerState<UploadWidget> createState() => _UploadWidgetState();
}

class _UploadWidgetState extends ConsumerState<UploadWidget> {
  @override
  Widget build(BuildContext context) {
    ref.read(filePickerNotifierProvider());
    // TODO: implement build
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      width: context.width,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                // color: AppColor.primary,
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(50),
                //   topRight: Radius.circular(50),
                // ),
                ),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  width: context.width,
                  child: const Text('Upload Files'),
                ),
                CustomFilledButton(
                  title: 'Pick file from gallery',
                  onTap: () async {
                    final data = await ref
                        .read(filePickerNotifierProvider().notifier)
                        .pickImage(
                          source: ImageSource.gallery,
                          isMultiple: true,
                        );

                    if (data != null) {
                      // ignore: use_build_context_synchronously
                      AppUtils.snackBar(
                        context,
                        'Error',
                        data,
                      );
                    }
                    context.popRoute();
                  },
                ),
                CustomFilledButton(
                  title: 'Pick files',
                  onTap: () async {
                    final data = await ref
                        .read(filePickerNotifierProvider().notifier)
                        .pickFiles(
                      extensionList: [FileTypes.pdf],
                      allowedMultile: true,
                    );

                    if (data != null) {
                      // ignore: use_build_context_synchronously
                      AppUtils.snackBar(
                        context,
                        'Error',
                        data,
                      );
                    }
                    context.popRoute();
                  },
                ),
                CustomFilledButton(
                  title: 'Clear data',
                  onTap: () {
                    ref
                        .read(filePickerNotifierProvider().notifier)
                        .clearState();
                    context.popRoute();
                  },
                ),
                CustomFilledButton(
                  title: 'Camera Page',
                  onTap: () async {
                    await ref
                        .read(filePickerNotifierProvider().notifier)
                        .getMultiCameraImages(context: context);

                    context.popRoute();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
