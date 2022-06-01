import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/users.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/big_button.dart';
import 'package:voto_mobile/widgets/login/custom_textform.dart';
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
  final FocusNode _emailNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  bool isSubmitted = false;

  Future<void> handleLogin() async {
    setState(() => isSubmitted = true);
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

      final profileImg = await FirebaseDatabase.instance.ref('users/${credential.user?.uid}/img').get();
      Provider.of<PersistentState>(context, listen: false).updateUser(Users(
        uid: credential.user?.uid,
        displayName: credential.user?.displayName,
        email: credential.user?.email,
        img: profileImg.value as String
      ));

      snackBar.text = "Welcome, ${credential.user?.displayName}";
      snackBar.icon = Icons.check_circle;
      snackBar.accentColor = VotoColors.success;

      FocusScope.of(context).unfocus();
      Navigator.pushNamed(context, '/home_page');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // doSth
      } else if (e.code == 'wrong-password') {
        // doSth
      }
    } finally {
      _passwordController.clear();
      setState(() => isSubmitted = false);
      snackBar.show(context);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailNode.dispose();
    _passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VotoColors.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42.5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    width: 250,
                    height: 150,
                  ),
                  const SizedBox(height: 50.0),
                  CustomTextForm(
                    controller: _emailController,
                    focusNode: _emailNode,
                    hintText: 'Email',
                    maxLength: 320,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordNode)
                  ),
                  const SizedBox(height: 25.0),
                  CustomTextForm(
                    controller: _passwordController,
                    focusNode: _passwordNode,
                    hintText: 'Password',
                    maxLength: 100,
                    icon: Icons.lock_rounded,
                    obscureText: true,
                  ),
                  const SizedBox(height: 50.0),
                  BigButton(
                    text: 'Login',
                    isLoading: isSubmitted,
                    onPressed: handleLogin,
                  ),
                  const SizedBox(height: 25.0),
                  const SignUpClick(),
                ],
              ),
          ),
        ),
      )
    );
  }
}