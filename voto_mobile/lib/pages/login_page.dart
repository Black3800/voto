import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/big_button.dart';
import 'package:voto_mobile/widgets/login/custom_textform.dart';
import 'package:voto_mobile/widgets/login/loading_button.dart';
import 'package:voto_mobile/widgets/login/sign_up_click.dart';
import 'package:voto_mobile/widgets/voto_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void handleLogin() async {
    VotoSnackbar snackBar = VotoSnackbar(
      text: 'Please check your credentials and try again',
      icon: Icons.clear,
      accentColor: VotoColors.danger
    );

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text
          );

      snackBar.text = "Welcome, ${credential.user?.displayName}";
      snackBar.icon = Icons.check_circle;
      snackBar.accentColor = VotoColors.success;

      Navigator.pushNamed(context, '/home_page');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // doSth
      } else if (e.code == 'wrong-password') {
        // doSth
      }
    } finally {
      _passwordController.clear();
      setState(() {});
      snackBar.show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VotoColors.primary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42.5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'logo.png',
                width: 250,
                height: 150,
              ),
              const SizedBox(height: 50.0),
              CustomTextForm(
                controller: _emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 25.0),
              CustomTextForm(
                controller: _passwordController,
                hintText: 'Password',
                maxLength: 100,
                icon: Icons.lock_rounded,
                obscureText: true,
              ),
              const SizedBox(height: 50.0),
              LoadingButton(),
              // BigButton(
              //   text: 'Login',
              //   onPressed: handleLogin,
              // ),
              const SizedBox(height: 25.0),
              const SignUpClick(),
            ],
          ),
      )
    );
  }
}