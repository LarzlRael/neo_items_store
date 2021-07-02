import 'package:flutter/material.dart';
import 'package:neo_wallet/navigation/bottom_navigation.dart';
import 'package:neo_wallet/pages/loading_page.dart';
import 'package:neo_wallet/pages/login_page.dart';
import 'package:neo_wallet/pages/register_page.dart';
import 'package:neo_wallet/pages/send_page.dart';
import 'package:neo_wallet/pages/transaccion_details.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  /* Register and login  */
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),

  /*  */
  'home': (_) => BottomNavigation(),
  'loading': (_) => LoadingPage(),
  'transactionDetails': (_) => TransaccionDetails(),
  'sendPage': (_) => SendPage(),
};