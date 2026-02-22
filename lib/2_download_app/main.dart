import 'package:flutter/material.dart';
import 'ui/providers/theme_color_provider.dart';
import 'ui/screens/settings/settings_screen.dart';
import 'ui/screens/downloads/downloads_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ChangeTheme themeNotifier = ChangeTheme();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeNotifier,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: Home(themeNotifier: themeNotifier),
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  final ChangeTheme themeNotifier;

  const Home({super.key, required this.themeNotifier});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      DownloadsScreen(themeNotifier: themeNotifier),
      SettingsScreen(themeNotifier: themeNotifier),
    ];
    
    return Scaffold(
      body: pages[themeNotifier.currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: themeNotifier.currentIndex,
        onTap: (index) {
          themeNotifier.onTabChange(index);
        },
        selectedItemColor: themeNotifier.themeColor.color,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Downloads'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Settings'),
        ],
      )
    );
  }
}
