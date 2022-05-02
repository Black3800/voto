import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/big_button.dart';
import 'package:voto_mobile/widgets/login/custom_textform.dart';
import 'package:voto_mobile/widgets/login/sign_up_click.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final SnackBar failedSnackBar = SnackBar(
                                    content: Row(children: const [
                                      Icon(Icons.clear, color: VotoColors.danger),
                                      SizedBox(width: 10.0),
                                      Text('Please check your credentials and try again')
                                    ]),
                                  );

  SnackBar successSnackBar(name) => SnackBar(
                                      content: Row(children: [
                                        const Icon(Icons.check_circle, color: VotoColors.success),
                                        const SizedBox(width: 10.0),
                                        Text("Welcome, ${name ?? 'Anonymous'}!")
                                      ]),
                                    );

  void handleLogin() async {
    SnackBar snackBar = failedSnackBar;

    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text
          );

      snackBar = successSnackBar(credential.user?.displayName);
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
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              CustomTextForm(controller: _emailController, isEmail: true),
              const SizedBox(height: 25.0),
              CustomTextForm(controller: _passwordController, isEmail: false),
              const SizedBox(height: 50.0),
              BigButton(
                text: 'Login',
                onPressed: handleLogin,
              ),
              const SizedBox(height: 25.0),
              const SignUpClick(),
            ],
          ),
      )
    );
  }
}