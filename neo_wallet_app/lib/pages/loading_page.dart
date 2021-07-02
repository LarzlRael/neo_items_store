import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:neo_wallet/navigation/bottom_navigation.dart';
import 'package:neo_wallet/pages/login_page.dart';
import 'package:neo_wallet/services/auth_services.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere ....'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.isLoggenIn();

    if (autenticado) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => BottomNavigation(),
          transitionDuration: Duration(milliseconds: 0),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0),
        ),
      );
    }
  }
}
