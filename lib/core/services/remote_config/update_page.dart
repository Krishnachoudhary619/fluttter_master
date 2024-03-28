import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../presentation/shared/gen/assets.gen.dart';
import '../../../presentation/shared/providers/app_content.dart';
import '../../../presentation/theme/app_color.dart';
import '../../extension/context.dart';
import '../../utils/app_utils.dart';

@RoutePage()
class UpdatePage extends ConsumerStatefulWidget {
  const UpdatePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UpdatePageState();
}

class _UpdatePageState extends ConsumerState<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    final appContentData = ref.read(appContentProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.svg.mobileUpdate.svg(
              width: (context.width < context.height)
                  ? context.widthByPercent(40)
                  : context.heightByPercent(40),
            ),
            const Gap(20),
            const Text(
              'New Update Available',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Gap(20),
            const Text(
              'To use this app, download the latest version',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => AppUtils.lauchStore(
                      iosId: appContentData.iOSAppId,
                      playStoreAppId: appContentData.androidAppId,
                    ),
                    style: OutlinedButton.styleFrom(
                      elevation: 0,
                      side: const BorderSide(
                        color: AppColor.primary,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'More info',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => AppUtils.lauchStore(
                      iosId: appContentData.iOSAppId,
                      playStoreAppId: appContentData.androidAppId,
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      backgroundColor: AppColor.primary,
                      shape: const StadiumBorder(),
                    ),
                    child: Text(
                      'Update',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
