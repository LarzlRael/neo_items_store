import 'package:flutter/material.dart';
import 'package:neo_wallet/pages/items_page.dart';
import 'package:neo_wallet/pages/managament_page.dart';
import 'package:neo_wallet/pages/wallet_page.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndex),
      bottomNavigationBar: _createNavigatorBar(context),
    );
  }

  _callPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return WalletPage();
      case 1:
        return ItemsPage();
      case 2:
        return ManagamentPage();

      default:
        return WalletPage();
    }
  }

  Widget _createNavigatorBar(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Color(0xff212B37),
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.wallet_membership_rounded), label: 'Wallets'),
        BottomNavigationBarItem(
            icon: Icon(Icons.wallet_giftcard), label: 'Items'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Manage'),
      ],
    );
  }
}
