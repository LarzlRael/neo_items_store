import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:neo_wallet/enviroments/variables_enviroments.dart'
    as Enviroments;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:neo_wallet/models/login_response.dart';
import 'package:neo_wallet/models/usuario.dart';

class AuthService with ChangeNotifier {
  //
  late Usuario usuario;
  bool _authtecating = false;

  final _storage = FlutterSecureStorage();

  set autenticando(bool valor) {
    this._authtecating = valor;
    notifyListeners();
  }

  // token static getters

  static Future<String> getToken() async {
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token != null ? token : '';
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  bool get autenticando => this._authtecating;

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password};

    final resp = await http.post(
      Uri.parse('${Enviroments.serverHttpUrl}/auth/login/'),
      body: jsonEncode(data),
      headers: {'Content-type': 'application/json'},
    );

    print(resp.body);

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String email, String password, String name) async {
    this.autenticando = true;

    final data = {'email': email, 'password': password, 'name': name};

    final resp = await http.post(
      Uri.parse(
        '${Enviroments.serverHttpUrl}/auth/register',
      ),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(data),
    );

    print(resp.body);

    this.autenticando = true;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggenIn() async {
    final token = await this._storage.read(key: 'token');
    final resp = await http.get(
      Uri.parse('${Enviroments.serverHttpUrl}/auth/renew'),
      headers: {
        'Content-type': 'application/json',
        'x-token': token != null ? token : '',
      },
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._saveToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
