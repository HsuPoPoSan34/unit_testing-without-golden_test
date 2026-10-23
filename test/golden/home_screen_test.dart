import 'package:unit_testing/features/home/home_screen.dart';

import 'golden_test_helpers.dart';

void main() {
  testScreenGoldens(folder: 'home', 
  buildScreen: (_) => const HomeScreen());
}
