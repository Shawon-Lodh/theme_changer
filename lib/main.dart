/*
    Created by Shawon Lodh on 16 May 2022
*/

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_changer/custom_theme_data.dart';

final callMenuTheme = ThemeData(
  primarySwatch: Colors.orange,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.orange),
  iconTheme: const IconThemeData(
    color: Colors.orange,
  ),
);

final cameraMenuTheme = ThemeData(
  primarySwatch: Colors.red,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red),
  iconTheme: const IconThemeData(
    color: Colors.red,
  ),
);

final chatMenuTheme = ThemeData(
  primarySwatch: Colors.green,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
  iconTheme: const IconThemeData(
    color: Colors.green,
  ),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
      ],
      path: 'assets/translations',
      saveLocale: true,
      fallbackLocale: const Locale('en'),
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CustomThemeData(callMenuTheme),
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: Provider.of<CustomThemeData>(context).getThemeData(),
          home: const BasicBottomNavBar(),
          //
        );
      },
    );
  }

}

class BasicBottomNavBar extends StatefulWidget {
  const BasicBottomNavBar({Key? key}) : super(key: key);

  @override
  _BasicBottomNavBarState createState() => _BasicBottomNavBarState();
}

class _BasicBottomNavBarState extends State<BasicBottomNavBar> {

  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    Icon(
      Icons.call,
      size: 150,
    ),
    Icon(
      Icons.camera,
      size: 150,
    ),
    Icon(
      Icons.chat,
      size: 150,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    final themeNotifier = Provider.of<CustomThemeData>(context, listen: false);
    switch(index) {
      case 0:
        themeNotifier.setThemeData(callMenuTheme);
        break;

      case 1:
        themeNotifier.setThemeData(cameraMenuTheme);
        break;

      case 2:
        themeNotifier.setThemeData(chatMenuTheme);
        break;

      default:
        themeNotifier.setThemeData(callMenuTheme);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Demo'),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.chat),
          //   label: 'Chats',
          // ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}