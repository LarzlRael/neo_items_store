import 'package:flutter/material.dart';
import 'package:neo_wallet/models/itemModel.dart';

class ShoppingCarService with ChangeNotifier {
  List<ItemModel> availableItems = [
    ItemModel(
      amount: 50,
      gameName: 'Dota 2',
      itemDescription: 'Es un buen item we',
      imagePoster: 'https://cdn.wallpapersafari.com/32/78/Hh7rSm.jpg',
      imageBackGround: 'https://wallpapercave.com/wp/wp2532627.jpg',
      id: 1,
      stock: 10,
    ),
    ItemModel(
        amount: 70,
        gameName: 'Free fire',
        itemDescription: 'Gemas de Free fire',
        stock: 15,
        imagePoster:
            'https://i.pinimg.com/564x/cd/2b/23/cd2b231b3cd9de5c215e8836ba6b3386.jpg',
        imageBackGround:
            'http://freefiremobile-a.akamaihd.net/ffwebsite/images/wallpaper/img54.jpg',
        id: 2),
    ItemModel(
        amount: 100,
        gameName: 'War Craft 3',
        itemDescription: 'Desc',
        imagePoster:
            'https://static.wikia.nocookie.net/es_wowpedia/images/1/1f/War3_box_frozenthrone.jpg/revision/latest/scale-to-width-down/250?cb=20110617061931',
        stock: 55,
        imageBackGround:
            'https://c4.wallpaperflare.com/wallpaper/979/289/69/warcraft-orcs-warcraft-iii-reign-of-chaos-warcraft-iii-wallpaper-preview.jpg',
        id: 3),
    ItemModel(
        amount: 50,
        gameName: 'Dota 2',
        itemDescription: 'Defense of the ancients',
        stock: 100,
        imagePoster:
            'https://yt3.ggpht.com/ytc/AKedOLRMjRvSs5MdXki23-b6zc6rgU19FOCRog5q2xu5=s900-c-k-c0x00ffffff-no-rj',
        imageBackGround: 'https://cdn.wallpapersafari.com/3/10/wgUAGc.jpg',
        id: 4),
    ItemModel(
        amount: 70,
        gameName: 'Free fire',
        itemDescription: 'Gemas de Free fire',
        stock: 15,
        imagePoster:
            'https://i.pinimg.com/564x/cd/2b/23/cd2b231b3cd9de5c215e8836ba6b3386.jpg',
        imageBackGround:
            'http://freefiremobile-a.akamaihd.net/ffwebsite/images/wallpaper/img54.jpg',
        id: 2),
    ItemModel(
        amount: 100,
        gameName: 'Clash Royale',
        imagePoster:
            'https://yt3.ggpht.com/ytc/AKedOLRMjRvSs5MdXki23-b6zc6rgU19FOCRog5q2xu5=s900-c-k-c0x00ffffff-no-rj',
        imageBackGround:
            'https://i1.wp.com/hipertextual.com/wp-content/uploads/2016/03/Clash-Royale.jpg?fit=1920%2C1080&ssl=1',
        itemDescription: '25 Gemas de free fire ',
        stock: 7,
        id: 6),
  ];
  List<ItemModel> selectedItems = [];

  late int amount = 0;
  bool showBuyButton = false;
  int totalAmout = 0;

  void addCarShopping(
    ItemModel item,
    dynamic idSelected,
  ) {
    item.idSelected = idSelected;

    selectedItems.add(item);
    this.getAmount();
    verifyCarShopping();
    notifyListeners();
  }

  void removeItem(ItemModel item) {
    this.selectedItems = this
        .selectedItems
        .where((i) => i.idSelected != item.idSelected)
        .toList();
    this.getAmount();
    this.verifyCarShopping();
    notifyListeners();
  }

  void getAmount() {
    this.totalAmout = 0;

    if (selectedItems.length == 0) {
      return;
    }
    this.selectedItems.forEach((element) {
      this.totalAmout += element.amount;
    });
    notifyListeners();
  }

  void verifyCarShopping() {
    if (this.selectedItems.length == 0) {
      this.showBuyButton = false;
      notifyListeners();
    } else {
      this.showBuyButton = true;
    }
  }
}
