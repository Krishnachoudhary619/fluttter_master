import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers/shared_timer_provider.dart';
import '../../core/providers/token_provider.dart';
import '../../core/services/remote_config/update_page.dart';
import '../shared/components/custom_filled_button.dart';
import '../shared/components/files_selecting_widget.dart';
import '../shared/providers/file_picking_provider.dart';
import '../theme/config/app_color.dart';
import 'providers/home_notifier.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeNotifierProvider.notifier).getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final state = ref.watch(homeNotifierProvider);

    ref.read(homeNotifierProvider);
    final token = ref.watch(tokenNotifierProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('${state.data}'),
            Text('$token'),

            ElevatedButton(
              onPressed: () {
                // context.pushRoute(const SecondRoute());
                ref.read(timerProviderProvider.notifier).startTime(seconds: 3);
              },
              child: const Text('Second page'),
            ),
            Consumer(
              builder: (context, ref, child) {
                final timerData = ref.watch(timerProviderProvider);
                if (timerData != 0) {
                  return const Text('Error');
                }
                return const SizedBox();
              },
            ),

            CustomFilledButton(
              title: 'show upload widget',
              onTap: () async {
                await showModalBottomSheet(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  isScrollControlled: true,
                  enableDrag: true,
                  backgroundColor: AppColor.white,
                  context: context,
                  builder: (context) {
                    return UploadWidget(
                      filePathCtrl: TextEditingController(),
                      allowedExtensions: const [
                        'jpeg',
                        'jpg',
                        'png',
                        'pdf',
                        'HEIC',
                      ],
                    );
                  },
                );
              },
            ),

            Consumer(
              builder: (context, ref, child) {
                final data = ref.watch(filePickerNotifierProvider());
                return Column(
                  children: List.generate(
                    data.length,
                    (index) => Text(data[index]),
                  ),
                );
              },
            ),

            CustomFilledButton(
              title: 'update Page',
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdatePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
