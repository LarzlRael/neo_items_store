import 'package:flutter/material.dart';
import 'package:neo_wallet/widgets/widgets.dart';

class WalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createWalletData(context),

          Container(
            margin: EdgeInsets.only(top: 15, left: 15, bottom: 15),
            child: Text(
              'Transacciones',
              style: TextStyle(color: Colors.white38, fontSize: 17),
            ),
          ),
          //
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(15),
              scrollDirection: Axis.vertical,
              children: [
                /* _createInfoBloc(),
                _createInfoBloc(),
                _createInfoBloc(), */

                _createInfoBloc(context),
                _createInfoBloc(context),
                _createInfoBloc(context),
                _createInfoBloc(context),
                _createInfoBloc(context),
                _createInfoBloc(context),
                _createInfoBloc(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createWalletData(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    final titleStyle = TextStyle(
        color: Colors.white, fontSize: 26, fontWeight: FontWeight.w500);
    final subTitleStyle = TextStyle(color: Colors.white, fontSize: 17);

    return Container(
      height: mediaQuery.height * 0.33,
      width: double.infinity,
      /* color: Colors.blue, */
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF06B1FF),
            Color(0xFF0076FE),
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Etherum', style: titleStyle),
                Text('1740.58 USD per ETH', style: subTitleStyle),
              ],
            ),
            Column(
              children: [
                Text('0.00000000012 ETH', style: titleStyle),
                Text('0.47 USD', style: subTitleStyle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWithIcon(
                  label: 'Enviar',
                  icon: (Icons.send_and_archive_rounded),
                  buttonBorderPrimary: false,
                ),
                ButtonWithIcon(
                    label: 'Recibir',
                    icon: (Icons.qr_code),
                    buttonBorderPrimary: false),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _createInfoBloc(BuildContext context) {
    final color = Color(0xff7BC896);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Color(0xff212B37),
        border: Border.all(width: 0.5, color: Colors.black),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.arrow_circle_up,
                    size: 35,
                    color: color,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Sent',
                    style: TextStyle(fontSize: 18, color: color),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '01/05/2021, 14:33',
                    style: TextStyle(fontSize: 13, color: Colors.white54),
                  ),
                  SizedBox(height: 7),
                  Text(
                    '0x1750bab89...4fd626984e0',
                    style: TextStyle(fontSize: 13, color: Colors.white54),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 10),
          Divider(
            color: Colors.white38,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'transactionDetails');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0.025454641651515151 ETH',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
