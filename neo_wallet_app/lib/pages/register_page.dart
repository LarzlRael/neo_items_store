import 'package:flutter/material.dart';
import 'package:neo_wallet/widgets/widgets.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

class _Form extends StatelessWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final nameCtrl = TextEditingController();
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail,
            placeholder: 'Correo electronico',
            isPassword: false,
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.icecream,
            placeholder: 'Ingrese su nombre',
            isPassword: false,
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.lock,
            placeholder: 'Ingrese su Contraseña',
            isPassword: true,
            keyboardType: TextInputType.text,
            textController: passCtrl,
          ),
          ButtonBlue(
            title: 'Registrarse',
            onPressed: () => Navigator.pushNamed(context, 'home'),
          ),
        ],
      ),
    );
  }
}
