import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neo_wallet/models/wallets_users_response.dart';
import 'package:neo_wallet/services/wallet_services.dart';
import 'package:neo_wallet/widgets/widgets.dart';

class NewWallet extends StatefulWidget {
  @override
  _NewWalletState createState() => _NewWalletState();
}

class _NewWalletState extends State<NewWallet> {
  List<UserWallet> userWallets = [];

  @override
  void initState() {
    _loadWallets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nombre de usuario'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: this.userWallets.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int i) {
                return _showWallet(context, userWallets[i]);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: FatButton(
              title: 'Agregar nueva billetera',
              onPressed: () => {_createDialog(context)},
            ),
          ),
        ],
      ),
    );
  }

  Widget _showWallet(BuildContext context, UserWallet userWallet) {
    return Column(
      children: [
        Divider(),
        Container(
          width: double.infinity,
          child: ListTile(
            onTap: () {
              Navigator.pushNamed(context, 'qrPage', arguments: userWallet.id);
            },
            leading: Icon(Icons.wallet_giftcard),
            title: Text(userWallet.walletName),
            subtitle: Text('${userWallet.balance}'),
            trailing: Icon(Icons.qr_code_2),
          ),
        ),
        Divider(),
      ],
    );
  }

  _createDialog(BuildContext context) {
    final nameWallet = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Color(0xff25313F),
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.all(10),
          buttonPadding: EdgeInsets.zero,
          title: Center(child: Text('Larz')),
          content: Container(
            height: 170,
            child: (Column(
              children: [
                Text('Nombre de billetera',
                    style: TextStyle(fontWeight: FontWeight.w300)),
                SizedBox(height: 15),
                CustomInput(
                  icon: Icons.ac_unit,
                  placeholder: 'Nombre de billetera',
                  textController: nameWallet,
                ),
                SizedBox(height: 20),
                FatButton(
                  title: 'Guardar',
                  onPressed: () => {
                    onSubmitNewWallet(context, nameWallet),
                  },
                ),
              ],
            )),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xff212B37),
                ),
                child: Center(child: Text('Cancelar')),
              ),
            ),
          ],
        ),
      );
    }
  }

  onSubmitNewWallet(
      BuildContext context, TextEditingController nameWallet) async {
    print(nameWallet.text.trim());
    final walletService = WalletServices();
    final respOk = await walletService.createNewWallet(nameWallet.text.trim());

    if (respOk) {
      Navigator.pop(context);
    }
  }

  void _loadWallets() async {
    final walletServies = WalletServices();
    this.userWallets = await walletServies.getUserTransactions();
    setState(() {});
  }
}
