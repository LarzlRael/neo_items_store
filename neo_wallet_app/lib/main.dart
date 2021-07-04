import 'package:flutter/material.dart';

import 'package:neo_wallet/routes/routes.dart';
import 'package:neo_wallet/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'loading',
        routes: appRoutes,
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
      ),
    );
  }
}
