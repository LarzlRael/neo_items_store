import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:neo_wallet/widgets/wallet_status.dart';
import 'package:neo_wallet/widgets/widgets.dart';

class SendPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WalletStatus(
            showButton: false,
            walletHeightSize: 0.25,
          ),
          containerElements(context),
        ],
      ),
    );
  }

  Widget containerElements(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            _createInput(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonWithIcon(
                  icon: Icons.qr_code,
                  label: 'Scan',
                  buttonBorderPrimary: true,
                  onPressed: () {},
                ),
                ButtonWithIcon(
                  icon: Icons.qr_code,
                  label: 'Paste',
                  buttonBorderPrimary: true,
                  onPressed: () {},
                ),
              ],
            ),
            _createInput(),
            _sendButton(context),
          ],
        ));
  }

  Container _createInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, top: 20),
      padding: EdgeInsets.only(top: 0, left: 15, bottom: 0, right: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white38),
        borderRadius: BorderRadius.all(Radius.circular(
          25,
        )),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Ingrese direccion en recibo",
        ),
      ),
    );
  }

  Widget _sendButton(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'sendPage');
        },
        child: Text('Enviar'),
      ),
    );
  }
}
