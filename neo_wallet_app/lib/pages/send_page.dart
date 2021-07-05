import 'package:flutter/material.dart';

import 'package:neo_wallet/helpers.dart';
import 'package:neo_wallet/models/wallets_users_response.dart';
import 'package:neo_wallet/services/transactions_services.dart';
import 'package:neo_wallet/widgets/wallet_status.dart';
import 'package:neo_wallet/widgets/widgets.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class SendPage extends StatefulWidget {
  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  //

  TextEditingController walletDirectionToSend = TextEditingController();
  TextEditingController amount = TextEditingController();

  double _currentSliderValue = 0;

  late UserWallet walletArgument;

  @override
  Widget build(BuildContext context) {
    this.walletArgument =
        ModalRoute.of(context)!.settings.arguments as UserWallet;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletStatus(
                showButton: false,
                walletHeightSize: 0.25,
              ),
              containerElements(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget containerElements(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text('Billetera: ${walletArgument.walletName}'),
            Text('Saldo Actual: ${walletArgument.balance}'),
            _createInput(walletDirectionToSend, 'Ingrese direccion de recibo'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonWithIcon(
                  icon: Icons.qr_code,
                  label: 'Scan',
                  buttonBorderPrimary: true,
                  onPressed: scanQr,
                ),
                ButtonWithIcon(
                  icon: Icons.paste,
                  label: 'Paste',
                  buttonBorderPrimary: false,
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text('Enviar : ${this._currentSliderValue}'),
            _createSlider(walletArgument.balance),
            _createInput(amount, 'Saldo'),
            _sendButton(context),
          ],
        ));
  }

  Container _createInput(
      TextEditingController editingController, String placeHolder) {
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
        controller: editingController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: placeHolder,
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
        onPressed: () => {sendAmount()},
        child: Text('Enviar'),
      ),
    );
  }

  void scanQr() async {
    /* try {
      StringbarcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "cancel", false, ScanMode.DEFAULT);
    } catch (e) {
      barcodeScanRes = e.toString();
    } */
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancelar", false, ScanMode.DEFAULT);

    print('futureString : $barcodeScanRes');

    setState(() {
      this.walletDirectionToSend.text = barcodeScanRes;
    });
  }

  _createSlider(int balance) {
    return Slider(
      value: _currentSliderValue,
      min: 0,
      max: balance.toDouble(),
      divisions: 5,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }

  void sendAmount() async {
    final transactionsServices = TransactionsServices();
    final respOK = await transactionsServices.sendAmountToServer(
      amount: this._currentSliderValue.toInt(),
      userOriginWallet: this.walletArgument.id,
      userTargetWallet: this.walletDirectionToSend.text,
    );
    if (respOK) {
      Navigator.pushNamed(context, 'home');
    } else {
      mostrarAlerta(context, 'Error',
          'Hubo un error en la transaccion, revise la direccion de envio');
    }
  }
}
