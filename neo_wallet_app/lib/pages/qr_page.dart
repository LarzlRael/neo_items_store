import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:neo_wallet/services/qr_services.dart';

class QrPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    final qrService = QrService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Recibir por medio de QR'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: FutureBuilder(
            future: qrService.getWalletQr(args),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return Image.memory(base64Decode(snapshot.data));
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
