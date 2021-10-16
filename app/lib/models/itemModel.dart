class ItemModel {
  int amount;
  String gameName;
  String itemDescription;
  int stock;
  String imageBackGround;
  String imagePoster;
  int id;
  dynamic idSelected;
  ItemModel({
    required this.amount,
    required this.stock,
    required this.id,
    required this.gameName,
    required this.itemDescription,
    required this.imageBackGround,
    required this.imagePoster,
  });
}
