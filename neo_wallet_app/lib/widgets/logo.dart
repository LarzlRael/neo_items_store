part of 'widgets.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      width: 160,
      child: Column(
        children: [
          Image(
            image: NetworkImage(
                'https://negocioexitoso.online/wp-content/uploads/2021/06/logo-blanco-1Kx1K-150x150.png'),
          ),
          SizedBox(height: 20),
          Text(title, style: TextStyle(fontSize: 30)),
        ],
      ),
    );
  }
}
