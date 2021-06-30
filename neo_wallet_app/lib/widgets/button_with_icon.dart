part of 'widgets.dart';

class ButtonWithIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool buttonBorderPrimary;
  final styleLabelButton = TextStyle(color: Colors.white, fontSize: 16);

  ButtonWithIcon(
      {required this.icon,
      required this.label,
      required this.buttonBorderPrimary});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: styleLabelButton),
      onPressed: () {},
      style: buttonsStyles(context),
    );
  }

  buttonsStyles(BuildContext context) {
    return ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 55, vertical: 10),
      shape: StadiumBorder(),
      primary: Colors.transparent,
      side: BorderSide(
        width: .8,
        color:
            buttonBorderPrimary ? Theme.of(context).accentColor : Colors.white,
      ),
    );
  }
}
