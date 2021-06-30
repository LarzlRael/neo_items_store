import 'package:flutter/material.dart';
import 'package:neo_wallet/pages/tabs/assets_tab_page.dart';
import 'package:neo_wallet/pages/tabs/transcations_tab_page.dart';

class ItemsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jhoe Doe'),
          centerTitle: true,
          elevation: 5,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.grid_on_sharp)),
          ],
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.qr_code)),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: null,
                text: 'Your assets',
              ),
              Tab(
                icon: null,
                text: 'Transactions',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            AssetsTabPage(),
            TransaccionTabPage(),
          ],
        ),
      ),
    );
  }
}
