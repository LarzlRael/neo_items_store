import 'package:flutter/material.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:neo_wallet/services/shopping_cart_service.dart';
import 'package:provider/provider.dart';
import 'package:material_dialogs/material_dialogs.dart';

class ButtonShowCar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final shoppingCarService =
        Provider.of<ShoppingCarService>(context, listen: true);
    final colorButton = Colors.white;
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        color: Colors.blue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorButton,
                ),
              ),
              Text(
                'BS ${shoppingCarService.totalAmout}',
                style: TextStyle(
                  fontSize: 20,
                  color: colorButton,
                ),
              ),
            ],
          ),
          _BtnPlay()
        ],
      ),
    );
  }
}

class _BtnPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Dialogs.bottomMaterialDialog(
            msg: '¿Esta seguro de confirmar compra?',
            title: 'Comprar',
            context: context,
            actions: [
              IconsOutlineButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Cancelar',
                iconData: Icons.cancel_outlined,
                textStyle: TextStyle(color: Colors.grey),
                iconColor: Colors.grey,
              ),
              IconsButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Dialogs.materialDialog(
                      color: Colors.white,
                      msg: 'Operacion realizada correctamente',
                      title: 'Operacion exitosa',
                      context: context,
                      actions: [
                        IconsButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          text: 'OK',
                          iconData: Icons.done,
                          color: Colors.green,
                          textStyle: TextStyle(color: Colors.white),
                          iconColor: Colors.white,
                        ),
                      ]);
                },
                text: 'Reservar',
                iconData: Icons.check,
                color: Colors.green,
                textStyle: TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ]);
      },
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon(Icons.shopping_cart, color: Colors.white),
          Text(
            'Reservar',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
