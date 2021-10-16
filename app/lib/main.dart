import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:neo_wallet/routes/routes.dart';
import 'package:neo_wallet/services/auth_services.dart';
import 'package:neo_wallet/services/push_notification_services.dart';
import 'package:neo_wallet/services/shopping_cart_service.dart';
import 'package:neo_wallet/services/socket_service.dart';
import 'package:neo_wallet/services/transactions_services.dart';
import 'package:neo_wallet/shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = UserPreferences();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => TransactionsServices()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => PushNotificationServices()),
        ChangeNotifierProvider(create: (_) => ShoppingCarService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: appRoutes,
        theme: ThemeData(
          brightness: Brightness.light,

          /* light theme settings */
        ),
      ),
    );
  }
}
//TODO add State from loading send transaction