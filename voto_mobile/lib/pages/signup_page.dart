import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/big_button.dart';
import 'package:voto_mobile/widgets/login/custom_textform.dart';
import 'package:voto_mobile/widgets/signup/header.dart';
import 'package:voto_mobile/widgets/voto_snackbar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool isSubmitted = false;

  String? _validateEmail(String? value) {
    RegExp emailRegex = RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$', caseSensitive: false);
    if (value == null || value.isEmpty) {
      return 'Required';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    } else if (value.length < 6) {
      return 'Password must be longer than 6 characters';
    }
    return null;
  }

  String? _validateConfirm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    } else if (value != _passwordController.text) {
      return 'Password does not match';
    }
    return null;
  }

  Future<void> _submitForm(BuildContext context) async {
    final String _email = _emailController.text;
    final String _name = _nameController.text;
    final String _password = _passwordController.text;
  
    VotoSnackbar snackBar = VotoSnackbar(
      text: 'Welcome to Vo-To!',
      icon: Icons.check_circle,
      accentColor: VotoColors.success);
        
    if (_formKey.currentState!.validate()) {
      try {
        /***
         * Create FirebaseAuth credential
         */
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email,
          password: _password
        );
        final user = credential.user;
        await user?.updateDisplayName(_name);
        await user?.updatePhotoURL("gs://cs21-voto.appspot.com/blank.webp");

        /***
         * Add user into database
         */
        DatabaseReference ref = FirebaseDatabase.instance.ref("users/${user?.uid}");
        await ref.set({
          "display_name": _name,
          "img": "gs://cs21-voto.appspot.com/dummy/blank.webp",
        });

        /***
         * Navigate to homepage
         */
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home_page');
      } on FirebaseAuthException catch(e) {
        /***
         * Prepare error message to show in snackbar
         */
        if(e.code == 'email-already-in-use') {
          snackBar.text = 'Email is already in used';
        } else if (e.code == 'invalid-email') {
          snackBar.text = 'Invalid email';
        } else if (e.code == 'weak-password') {
          snackBar.text = 'Your password is too weak';
        }
        snackBar.icon = Icons.clear;
        snackBar.accentColor = VotoColors.danger;
      } finally {
        isSubmitted = false;
        setState(() {});
        snackBar.show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VotoColors.white,
      body: Column(
        children: [
          const Header(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42.5),
              child: Form(
                key: _formKey,
                child: ListView.separated(
                    itemBuilder: (context, index) => [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 36.0),
                            child: Text(
                              "Create your account to start using Vo-To",
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: VotoColors.primary,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          CustomTextForm(
                            controller: _emailController,
                            validator: _validateEmail,
                            hintText: 'Email',
                            fillColor: VotoColors.gray,
                          ),
                          CustomTextForm(
                            controller: _nameController,
                            validator: _validateName,
                            maxLength: 30,
                            hintText: 'Display name',
                            icon: Icons.account_circle_rounded,
                            fillColor: VotoColors.gray,
                          ),
                          CustomTextForm(
                            controller: _passwordController,
                            validator: _validatePassword,
                            maxLength: 100,
                            hintText: 'Password',
                            icon: Icons.lock_rounded,
                            fillColor: VotoColors.gray,
                            obscureText: true,
                          ),
                          CustomTextForm(
                            controller: _confirmController,
                            validator: _validateConfirm,
                            maxLength: 100,
                            hintText: 'Confirm password',
                            icon: Icons.lock_rounded,
                            fillColor: VotoColors.gray,
                            obscureText: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 36.0),
                            child:  BigButton(
                                      text: 'Login',
                                      isLoading: isSubmitted,
                                      onPressed: () {
                                        setState(() => isSubmitted = true);
                                        _submitForm(context);
                                      },
                                    ),
                          ),
                        ][index],
                    separatorBuilder: (context, index) => const SizedBox(height: 15.0),
                    itemCount: 6
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
