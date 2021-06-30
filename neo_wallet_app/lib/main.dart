import 'package:flutter/material.dart';
import 'package:neo_wallet/pages/send_page.dart';
import 'package:neo_wallet/pages/transaccion_details.dart';

import 'navigation/bottom_navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (_) => BottomNavigation(),
        'transactionDetails': (_) => TransaccionDetails(),
        'sendPage': (_) => SendPage(),
      },
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xff1B242D),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xff212B37),
        ),
        /* bottomNavigationBarTheme: (BottomNavigationBarThemeData(
          backgroundColor: Color(0xff212B37),
          selectedItemColor: Colors.white,
          unselectedItemColor: Theme.of(context).primaryColor,
        )), */
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      /* ThemeMode.system to follow system theme, 
        ThemeMode.light for light theme, 
        ThemeMode.dark for dark theme
      */
    );
  }
}
