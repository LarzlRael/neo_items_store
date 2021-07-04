import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:neo_wallet/enviroments/variables_enviroments.dart'
    as Enviroments;
import 'package:neo_wallet/models/transactions_response.dart';
import 'package:neo_wallet/models/wallets_users_response.dart';

import 'auth_services.dart';

class QrService {
  Future<String> getWalletQr(String walletId) async {
    //
    final data = {'url': walletId};

    final resp = await http.post(
      Uri.parse('${Enviroments.serverHttpUrl}/qr'),
      headers: {
        'Content-type': 'application/json',
        'x-token': await AuthService.getToken()
      },
      body: jsonEncode(data),
    );

    final respBody = jsonDecode(resp.body);
    return respBody['src'];
  }

  /* if (resp.statusCode == 200) {
    final loginResponse = loginResponseFromJson(resp.body);
    this.usuario = loginResponse.usuario;
    await this._saveToken(loginResponse.token);
    return true;
  } else {
    return false;
  } */

  Future<bool> createNewWallet(String walletName) async {
    final data = {'walletName': walletName};

    final resp = await http.post(
      Uri.parse(
        '${Enviroments.serverHttpUrl}/wallet/createwallet',
      ),
      headers: {
        'Content-type': 'application/json',
        'x-token': await AuthService.getToken(),
      },
      body: jsonEncode(data),
    );
    final respBody = jsonDecode(resp.body);
    return respBody['ok'];
  }
}
