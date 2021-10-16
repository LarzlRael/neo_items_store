import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:neo_wallet/models/itemModel.dart';
import 'package:neo_wallet/services/shopping_cart_service.dart';
import 'package:neo_wallet/widgets/button_show_car.dart';
import 'package:provider/provider.dart';

class ItemDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ItemModel;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _createAppBar(item),
          SliverList(
              delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _posterTitulo(item, context),
            _description(item),
            _createMaterialButton(item, context),
          ]))
        ],
      ),
    );
  }

  Widget _createAppBar(ItemModel item) {
    return SliverAppBar(
      elevation: 2.0,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          item.gameName,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(item.imagePoster),
          placeholder: AssetImage('assets/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(ItemModel item, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: item.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(item.imagePoster),
                placeholder: AssetImage('assets/loading.gif'),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.gameName}',
                style: Theme.of(context).textTheme.headline5,
                overflow: TextOverflow.ellipsis,
              ),
              Text('BS. ${item.amount}',
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis),
            ],
          ))
        ],
      ),
    );
  }

  Widget _description(ItemModel item) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        item.itemDescription,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createMaterialButton(ItemModel item, BuildContext context) {
    final shoppingCarService =
        Provider.of<ShoppingCarService>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          shape: StadiumBorder(),
        ),
        onPressed: () {
          Dialogs.materialDialog(
              color: Colors.white,
              msg: 'Item agregado ',
              title: '${item.itemDescription}',
              context: context,
              actions: [
                IconsButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'OK',
                  iconData: Icons.done,
                  color: Colors.blue,
                  textStyle: TextStyle(color: Colors.white),
                  iconColor: Colors.white,
                ),
              ]);
          shoppingCarService.addCarShopping(item, 'xd');
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Añadir al carrito'),
            Icon(Icons.add_shopping_cart_sharp),
          ],
        ),
      ),
    );
  }
}
