import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neo_wallet/enviroments/variables_enviroments.dart'
    as Enviroments;
import 'package:neo_wallet/models/transactions_response.dart';

import 'auth_services.dart';

class TransactionsServices {
  //

  final _transactionsStreamController =
      StreamController<List<UserTransaction>>.broadcast();

  Function(List<UserTransaction>) get transactionsSink =>
      _transactionsStreamController.sink.add;

  Stream<List<UserTransaction>> get transactionsStream =>
      _transactionsStreamController.stream;

  void disposeStream() {
    _transactionsStreamController.close();
  }

  getUserTransactionsBloc() async {
    _transactionsStreamController.sink.add(await this.getUserTransactions());
    /* transactionsSink(_transactionsByUser); */
  }

  Future<List<UserTransaction>> getUserTransactions() async {
    final resp = await http.get(
      Uri.parse('${Enviroments.serverHttpUrl}/transactions/gettransactions/'),
      headers: {
        'Content-type': 'application/json',
        'x-token': await AuthService.getToken()
      },
    );

    final transactionsResponse = transactionsResponseFromJson(resp.body);

    return transactionsResponse.userTransactions;
  }

  Future<bool> sendAmountToServer({
    required int amount,
    required String userOriginWallet,
    required String userTargetWallet,
  }) async {
    final data = {
      'amount': amount,
      'userOriginWallet': userOriginWallet,
      'userTargetWallet': userTargetWallet,
    };
    final resp = await http.post(
      Uri.parse('${Enviroments.serverHttpUrl}/transactions/send/'),
      headers: {
        'Content-type': 'application/json',
        'x-token': await AuthService.getToken(),
      },
      body: jsonEncode(data),
    );

    print(resp.body);

    if (jsonDecode(resp.body)['ok']) {
      return true;
    }
    return false;
  }
}
