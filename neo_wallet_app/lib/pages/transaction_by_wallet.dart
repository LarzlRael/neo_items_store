import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:neo_wallet/models/transactions_response.dart';
import 'package:neo_wallet/models/wallets_users_response.dart';
import 'package:neo_wallet/services/transactions_services.dart';

import 'package:neo_wallet/utils/utils.dart';

import 'package:neo_wallet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class TransactionByWallet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserWallet;
    final transactionsServices = Provider.of<TransactionsServices>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(toCapitalize(args.walletName)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            FadeIn(
                duration: Duration(milliseconds: 1000),
                child: WalletCard(
                    amount: args.balance, nameWallet: args.walletName)),
            SizedBox(height: 15),
            Expanded(
              child: FutureBuilder(
                future: transactionsServices.transactionByWallet(args.id),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserTransaction>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.length == 0) {
                      return NoInformation(
                          icon: Icons.wallet_giftcard,
                          message: 'Esta billetera no tiene transacciones',
                          showButton: false,
                          iconButton: Icons.ac_unit_outlined);
                    }
                    return TransactionsInfo(userTransaction: snapshot.data!);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
