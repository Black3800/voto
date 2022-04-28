import 'package:flutter/material.dart';

class ProfileCustomEmailTextField extends StatefulWidget {
  const ProfileCustomEmailTextField({Key? key}) : super(key: key);

  @override
  State<ProfileCustomEmailTextField> createState() =>
      _ProfileCustomEmailTextFieldState();
}

class _ProfileCustomEmailTextFieldState
    extends State<ProfileCustomEmailTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        initialValue: 'Tanny_panit@gmail.com',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(
            0xFF999999,
          ),
        ),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Color(
              0xFF999999,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          hintText: 'Email',
          fillColor: Color(0xFFF2F4F8),
          filled: true,
        ),
        readOnly: true,
      ),
    );
  }
}
