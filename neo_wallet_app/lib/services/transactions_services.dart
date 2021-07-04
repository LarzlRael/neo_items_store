import 'package:http/http.dart' as http;
import 'package:neo_wallet/enviroments/variables_enviroments.dart'
    as Enviroments;
import 'package:neo_wallet/models/transactions_response.dart';

import 'auth_services.dart';

class TransactionsServices {
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

  /* if (resp.statusCode == 200) {
    final loginResponse = loginResponseFromJson(resp.body);
    this.usuario = loginResponse.usuario;
    await this._saveToken(loginResponse.token);
    return true;
  } else {
    return false;
  } */
}
