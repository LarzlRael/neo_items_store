import 'package:flutter/material.dart';
import 'package:neo_wallet/services/auth_services.dart';
import 'package:neo_wallet/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../helpers.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Logo(title: 'N.E.O'),
                ),
                _Form(),
                Labels(
                    route: 'register',
                    title: '¿No tienes cuenta?',
                    subTitle: 'Registrarse ahora')
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatelessWidget {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email,
            placeholder: "Ingrese su Email",
            isPassword: false,
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: 'Contraseña',
            keyboardType: TextInputType.text,
            textController: passCtrl,
            isPassword: true,
          ),
          ButtonBlue(
            title: 'Ingresar',
            onPressed: authService.autenticando
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    // print(emailCtrl.text);
                    // print(passCtrl.text);

                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginOk) {
                      /* socketService.connect(); */
                      Navigator.pushReplacementNamed(context, 'home');
                    } else {
                      //crear alerta
                      mostrarAlerta(context, 'Login incorrecto',
                          'Revise sus credenciales nuevamente');
                    }
                  },
          ),
        ],
      ),
    );
  }
}
