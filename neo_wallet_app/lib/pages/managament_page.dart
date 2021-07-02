import 'package:flutter/material.dart';
import 'package:neo_wallet/services/auth_services.dart';

class ManagamentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authservice = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Text('Jhoe Doe'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.grid_3x3_sharp),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            authservice.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
          icon: Icon(Icons.exit_to_app),
        ),
      ),
      body: Container(
        /* padding: EdgeInsets.all(15), */
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                /* border: Border.all(color: Color(0xff1B242D)), */
                color: Color(0xff212B37),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1.5),
                  )
                ],
              ),
              child: ListTile(
                title: Text('Wallet name'),
                subtitle: Text('Jhoe Doe'),
                trailing: Icon(Icons.edit),
              ),
            ),
            Divider(
              color: Colors.white24,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.symmetric(horizontal: BorderSide.none)),
              child: ListTile(
                leading: Icon(Icons.keyboard_tab_sharp),
                title: Text('Show Backup Phars'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            Divider(
              color: Colors.white24,
            ),
          ],
        ),
      ),
    );
  }
}
