import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (c) => GetMaterialApp(
        title: 'Flutter Demo',
        theme: c.getThemes,
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            FlutterLogo(size: 100),
          ],
        ),
      )
    );
  }
}


class ThemesModeData {
  static final light = ThemeData.light();
  static final dark = ThemeData.dark();
}
enum ThemesMode {
  light,
  dark,
}

class ThemeController extends GetxController {
  static ThemeController instance = Get.find();

    ThemesMode mode = ThemesMode.light;

  void switchTheme(ThemesMode _mode) {
    mode = _mode;
    update();
  }

  ThemeData get getThemes {
    switch (mode) {
      case ThemesMode.dark:
        return ThemesModeData.dark;
      default:
        return ThemesModeData.light;
    }
  }
}


