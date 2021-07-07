import 'package:flutter/material.dart';
import 'package:neo_wallet/services/socket_service.dart';
import 'package:neo_wallet/services/transactions_services.dart';

import 'package:provider/provider.dart';

class UserTransactionsHistoryPage extends StatefulWidget {
  @override
  _UserTransactionsHistoryPageState createState() =>
      _UserTransactionsHistoryPageState();
}

class _UserTransactionsHistoryPageState
    extends State<UserTransactionsHistoryPage> {
  late SocketService socketService;
  late TransactionsServices transactionsService;

  @override
  void initState() {
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.socketService.loadHistory();
    socketService.socket
        .on('transaction-real-time', socketService.listenTransaction);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _transactions = socketService.transactions;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: socketService.serverStatus == ServerStatus.Online
                  ? Text('Conectando')
                  : Text('Desconectando'),
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _transactions.length,
                itemBuilder: (_, i) => _transactions[i],
                reverse: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
