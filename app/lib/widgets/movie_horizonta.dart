import 'package:flutter/material.dart';
import 'package:neo_wallet/models/itemModel.dart';

class MovieHorizontal extends StatelessWidget {
  final List<ItemModel> items;

  MovieHorizontal({required this.items});
  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.55,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {}
    });
    return Container(
      height: _screenSize.height * 0.35,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        /* children: _tarjetas(), */
        itemCount: items.length,
        itemBuilder: (context, index) => _tarjeta(context, items[index]),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, ItemModel item) {
    /* pelicula.uniqueId = '${pelicula.id}-poster'; */
    final width = MediaQuery.of(context).size.width;
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Hero(
            tag: item.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              /* child: FadeInImage(
                image: AssetImage('assets/black_logo.png'),
                placeholder: AssetImage('assets/black_logo.png'),
                fit: BoxFit.cover,
                height: 300.0,
              ), */
              child: Container(
                padding: EdgeInsets.all(10),
                height: 250,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      item.imagePoster,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Positioned(
                  top: 0,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${item.gameName}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Stock ${(item.stock - 5)}/${item.stock}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            'BS ${item.amount}',
                            style: TextStyle(color: Colors.blue),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: StadiumBorder(),
                            elevation: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            item.itemDescription,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(
          context,
          'details',
          arguments: item,
        );
      },
    );
  }

  /* List<Widget> _tarjetas() {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: NetworkImage(
                  pelicula.getPosterImg(),
                ),
                fit: BoxFit.cover,
                height: 160.0,
              ),
            ),
          ],
        ),
      );
    }).toList();
  } */
}
