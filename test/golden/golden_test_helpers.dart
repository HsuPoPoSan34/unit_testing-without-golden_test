import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void testScreenGoldens({
  required String folder,
  required Widget Function(ThemeMode themeMode) buildScreen,
}) {
  setUpAll(() async {
    final fontLoader = FontLoader('GoldenFont')
      ..addFont(rootBundle.load('assets/fonts/NotoSansJP.ttf'));
    await fontLoader.load();
  });

  final viewports = <({String name, Size size})>[
    (name: 'phone', size: const Size(375, 667)),
    (name: 'tablet', size: const Size(800, 1280)),
  ];
  final themes = <({String name, ThemeMode mode})>[
    (name: 'light', mode: ThemeMode.light),
    (name: 'dark', mode: ThemeMode.dark),
  ];

  for (final viewport in viewports) {
    for (final theme in themes) {
      testWidgets(
        '${viewport.name} ${theme.name} $folder screen matches golden',
        (tester) async {
          tester.view.physicalSize = viewport.size;
          tester.view.devicePixelRatio = 1;
          addTearDown(tester.view.resetPhysicalSize);
          addTearDown(tester.view.resetDevicePixelRatio);
          await tester.pumpWidget(
            MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                fontFamily: 'GoldenFont',
              ),
              darkTheme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                  brightness: Brightness.dark,
                ),
                fontFamily: 'GoldenFont',
              ),
              themeMode: theme.mode,
              home: buildScreen(theme.mode),
            ),
          );
          await tester.pumpAndSettle();
          await expectLater(
            find.byType(MaterialApp),
            matchesGoldenFile(
              '../goldens/$folder/${viewport.name}_${theme.name}.png',
            ),
          );
        },
      );
    }
  }
}
