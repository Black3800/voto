import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/users.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/big_button.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';
import 'package:voto_mobile/widgets/voto_snackbar.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final FocusNode _emailNode = FocusNode();
  final FocusNode _nameNode = FocusNode();
  final FocusNode _passwordNode = FocusNode();
  final FocusNode _confirmNode = FocusNode();

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
      return 'At least 6 characters';
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
        Provider.of<PersistentState>(context, listen: false).updateUser(Users(
          uid: user!.uid,
          displayName: _name,
          email: _email,
          img: "gs://cs21-voto.appspot.com/dummy/blank.webp"
        ));
        Navigator.of(context).popAndPushNamed('/home_page');
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
        snackBar.show(context);
      }
    }
    isSubmitted = false;
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _emailNode.dispose();
    _nameNode.dispose();
    _passwordNode.dispose();
    _confirmNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VotoColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: VotoColors.indigo,
        leading: IconButton(
          iconSize: 24,
          icon: const Icon(
            Icons.chevron_left,
            color: VotoColors.primary,
            size: 24,
          ),
          splashRadius: 24,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
            'Sign up',
            style: GoogleFonts.inter(
                fontSize: 20,
                color: VotoColors.primary,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          )
      ),
      body: Column(
        children: [
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
                          SimpleTextInput(
                            controller: _emailController,
                            validator: _validateEmail,
                            focusNode: _emailNode,
                            max: 320,
                            icon: Icons.email_rounded,
                            accentColor: VotoColors.indigo,
                            hintText: 'Email',
                            hintColor: VotoColors.black.shade500,
                            hideCounter: true,
                            borderRadius: 18,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_nameNode)
                          ),
                          SimpleTextInput(
                            controller: _nameController,
                            validator: _validateName,
                            focusNode: _nameNode,
                            max: 30,
                            icon: Icons.account_circle_rounded,
                            accentColor: VotoColors.indigo,
                            hintText: 'Display name',
                            hintColor: VotoColors.black.shade500,
                            hideCounter: true,
                            borderRadius: 18,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordNode)
                          ),
                          SimpleTextInput(
                            controller: _passwordController,
                            validator: _validatePassword,
                            focusNode: _passwordNode,
                            max: 100,
                            icon: Icons.lock_rounded,
                            accentColor: VotoColors.indigo,
                            hintText: 'Password',
                            hintColor: VotoColors.black.shade500,
                            hideCounter: true,
                            obscureText: true,
                            borderRadius: 18,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_confirmNode)
                          ),
                          SimpleTextInput(
                            controller: _confirmController,
                            validator: _validateConfirm,
                            focusNode: _confirmNode,
                            max: 100,
                            icon: Icons.lock_rounded,
                            accentColor: VotoColors.indigo,
                            hintText: 'Confirm password',
                            hintColor: VotoColors.black.shade500,
                            hideCounter: true,
                            obscureText: true,
                            borderRadius: 18,
                            textInputAction: TextInputAction.done
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 36.0),
                            child:  BigButton(
                                      text: 'Sign up',
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
