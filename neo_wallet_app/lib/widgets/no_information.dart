part of 'widgets.dart';

class NoInformation extends StatelessWidget {
  final IconData icon;
  final String message;
  final bool showButton;

  const NoInformation(
      {Key? key,
      required this.icon,
      required this.message,
      required this.showButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 110, color: Colors.white38),
          SizedBox(height: 15),
          Text(message),
          SizedBox(height: 15),
          showButton
              ? ButtonWithIcon(
                  label: "Recibir ",
                  icon: Icons.qr_code,
                  buttonBorderPrimary: true,
                )
              : Container(),
        ],
      ),
    );
  }
}
