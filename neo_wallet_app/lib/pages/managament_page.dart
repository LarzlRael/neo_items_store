import 'package:flutter/material.dart';
import 'package:neo_wallet/helpers.dart';
import 'package:neo_wallet/models/wallets_users_response.dart';
import 'package:neo_wallet/services/auth_services.dart';
import 'package:neo_wallet/services/wallet_services.dart';
import 'package:neo_wallet/utils/utils.dart';
import 'package:provider/provider.dart';

class ManagamentPage extends StatefulWidget {
  @override
  _ManagamentPageState createState() => _ManagamentPageState();
}

class _ManagamentPageState extends State<ManagamentPage> {
  List<UserWallet> userWallets = [];

  @override
  void initState() {
    _loadWallets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    final usuario = authService.usuario;
    final authservice = AuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text(toCapitalize(usuario.name)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.grid_3x3_sharp),
            onPressed: () {
              print('go a la otra pagina we');
              Navigator.pushNamed(context, 'newWallet');
            },
          ),
        ],
        leading: IconButton(
          onPressed: () {
            mostrarAlertaCerrarSesion(context, logOut);
          },
          icon: Icon(Icons.exit_to_app),
        ),
      ),
      body: Container(
        /* padding: EdgeInsets.all(15), */
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: this.userWallets.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int i) {
                  return _createWallet(userWallets[i]);
                },
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

  Container _createWallet(UserWallet wallet) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
        subtitle: Text(wallet.walletName),
        trailing: Icon(Icons.edit),
      ),
    );
  }

  void _loadWallets() async {
    final walletServies = WalletServices();
    this.userWallets = await walletServies.getUserTransactions();
    setState(() {});
  }

  void logOut() {
    Navigator.pushReplacementNamed(context, 'login');
  }
}
