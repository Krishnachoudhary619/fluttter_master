import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../shared/gen/assets.gen.dart';

final navItemsProvider = Provider<List<NavData>>((ref) {
  return [
    NavData(
      label: 'Home',
      inactiveSvg: Assets.svg.home.path,
      activeSvg: Assets.svg.homeActive.path,
    ),
    NavData(
      label: 'Home',
      inactiveSvg: Assets.svg.home.path,
      activeSvg: Assets.svg.homeActive.path,
    ),
    NavData(
      label: 'Home',
      inactiveSvg: Assets.svg.home.path,
      activeSvg: Assets.svg.homeActive.path,
    ),
    NavData(
      label: 'Home',
      inactiveSvg: Assets.svg.home.path,
      activeSvg: Assets.svg.homeActive.path,
    ),
  ];
});

class NavData {
  NavData({
    required this.activeSvg,
    required this.label,
    required this.inactiveSvg,
  });
  final String activeSvg;
  final String inactiveSvg;
  final String label;
}
