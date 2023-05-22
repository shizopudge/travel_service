import 'package:flutter/material.dart';

import 'features/splash/ui/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow.shade900,
        ),
      ).copyWith(
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Lato',
            ),
      ),
      home: const SplashPage(),
    );
  }
}
