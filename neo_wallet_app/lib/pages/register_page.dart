import 'package:flutter/material.dart';
import 'package:neo_wallet/helpers.dart';
import 'package:neo_wallet/services/auth_services.dart';
import 'package:neo_wallet/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Logo(title: 'N.E.O'),
                ),
                _Form(),
                Labels(
                    route: 'login',
                    title: 'Entrar con mi cuenta',
                    subTitle: '¿Ya tienes cuenta?')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  @override
  Widget build(BuildContext context) {
    //
    final authService = Provider.of<AuthService>(context, listen: false);
    //
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.supervised_user_circle,
            placeholder: 'Ingrese su nombre',
            isPassword: false,
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.mail,
            placeholder: 'Correo electronico',
            isPassword: false,
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock,
            placeholder: 'Ingrese su Contraseña',
            isPassword: true,
            keyboardType: TextInputType.text,
            textController: passCtrl,
          ),
          FatButton(
            title: 'Crear cuenta',
            onPressed: authService.autenticando
                ? null
                : () async {
                    final registerOk = await authService.register(
                      emailCtrl.text.trim(),
                      passCtrl.text.trim(),
                      nameCtrl.text.trim(),
                    );
                    if (registerOk == true) {
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      mostrarAlerta(context, 'Registro incorrecto', registerOk);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
