import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:neo_wallet/services/shopping_cart_service.dart';
import 'package:neo_wallet/widgets/button_show_car.dart';
import 'package:neo_wallet/widgets/movie_horizonta.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final shoppingCarService =
        Provider.of<ShoppingCarService>(context, listen: true);

    return Scaffold(
      /* appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => _settingModalBottomSheet(context),
              icon: Icon(Icons.shopping_cart))
        ],
      ), */
      backgroundColor: Color(0xffF7F7F7),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hola, Juan',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.search,
                                size: 30,
                                color: Colors.grey[600],
                              ),
                              Text(
                                'Buscar articulo',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              size: 30,
                              color: Colors.grey[600],
                            ),
                            onPressed: () => _settingModalBottomSheet(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  MovieHorizontal(items: shoppingCarService.availableItems),
                  Text(
                    'Más artículos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 15),
                  createItemSelected(),
                ],
              ),
            ),
            shoppingCarService.showBuyButton
                ? Positioned(
                    bottom: 0,
                    child: FadeInUp(
                      duration: Duration(milliseconds: 350),
                      child: ButtonShowCar(),
                    ),
                  )
                : FadeOut(
                    child: Container(),
                  ),
          ],
        ),
      ),
    );
  }

  Widget createItemSelected() {
    var uuid = Uuid();
    final shoppingCarService =
        Provider.of<ShoppingCarService>(context, listen: false);
    return Expanded(
      child: ListView.builder(
        itemCount: shoppingCarService.availableItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              onTap: () => {
                    Navigator.pushNamed(
                      context,
                      'details',
                      arguments: shoppingCarService.availableItems[index],
                    ),
                  },
              /* leading: Icon(Icons.settings_input_component_outlined), */
              trailing: Text(
                "BS. ${shoppingCarService.availableItems[index].amount}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${shoppingCarService.availableItems[index].gameName}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${shoppingCarService.availableItems[index].itemDescription}",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ));
        },
      ),
    );
  }

  void _settingModalBottomSheet(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => createListView(),
    );
  }

  Widget createListView() {
    final color = Colors.grey[600];
    final shoppingCarService =
        Provider.of<ShoppingCarService>(context, listen: false);
    return shoppingCarService.selectedItems.length != 0
        ? SafeArea(
            child: Column(
              children: [
                SizedBox(height: 15),
                Text(
                  'Tu carrito de compras',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: shoppingCarService.selectedItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        onDismissed: (direction) => {
                          shoppingCarService.removeItem(
                              shoppingCarService.selectedItems[index])
                        },
                        key: Key(
                            shoppingCarService.selectedItems[index].gameName),
                        child: ListTile(
                            leading: Text(
                              "BS ${shoppingCarService.selectedItems[index].amount}",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${shoppingCarService.selectedItems[index].gameName}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "${shoppingCarService.selectedItems[index].itemDescription}",
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ),
                ButtonShowCar(),
              ],
            ),
          )
        : Container(
            child: Center(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart,
                      size: 175,
                      color: color,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Tu carrito esta vácio',
                      style: TextStyle(
                        color: color,
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
