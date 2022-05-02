import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class SignUpTextForm extends StatefulWidget {
  const SignUpTextForm({Key? key}) : super(key: key);

  @override
  State<SignUpTextForm> createState() => _SignUpTextFormState();
}

class _SignUpTextFormState extends State<SignUpTextForm> {
  var _controller = TextEditingController();
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();
  var _controller3 = TextEditingController();
  void _clearTextField(TextEditingController controller) {
    // Clear everything in the text field
    controller.clear();
    // Call setState to update the UI
    setState(() {});
  }

  void _clearTextField1(TextEditingController controller1) {
    // Clear everything in the text field
    controller1.clear();
    // Call setState to update the UI
    setState(() {});
  }

  void _clearTextField2(TextEditingController controller1) {
    // Clear everything in the text field
    controller1.clear();
    // Call setState to update the UI
    setState(() {});
  }

  void _clearTextField3(TextEditingController controller1) {
    // Clear everything in the text field
    controller1.clear();
    // Call setState to update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 55,
        right: 55,
        left: 55,
        bottom: 30,
      ),
      child: Column(
        children: [
          TextFormField(
            onChanged: ((value) {
              setState(() {});
            }),
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email_rounded,
                color: VotoColors.primary,
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
              suffixIcon: _controller.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: (() => _clearTextField(_controller)),
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black54,
                      ),
                    ),
            ),
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: VotoColors.primary,
            ),
            cursorColor: VotoColors.primary,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
            ),
            child: TextFormField(
              onChanged: ((value) {
                setState(() {});
              }),
              controller: _controller1,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle_rounded,
                  color: VotoColors.primary,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                hintText: 'Display Name',
                fillColor: Color(0xFFF2F4F8),
                filled: true,
                suffixIcon: _controller1.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: (() => _clearTextField1(_controller1)),
                        icon: Icon(
                          Icons.clear,
                          color: Colors.black54,
                        ),
                      ),
              ),
              autofocus: false,
              // style: const TextStyle(color: Color(0xFF141D3B)
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: VotoColors.primary,
              ),

              cursorColor: VotoColors.primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
            ),
            child: TextFormField(
              onChanged: ((value) {
                setState(() {});
              }),
              controller: _controller2,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  color: VotoColors.primary,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                hintText: 'Password',
                fillColor: Color(0xFFF2F4F8),
                filled: true,
                suffixIcon: _controller2.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: (() => _clearTextField2(_controller2)),
                        icon: Icon(
                          Icons.clear,
                          color: Colors.black54,
                        ),
                      ),
              ),
              autofocus: false,
              obscureText: true,
              // style: const TextStyle(color: Color(0xFF141D3B)
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: VotoColors.primary,
              ),

              cursorColor: VotoColors.primary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
            ),
            child: TextFormField(
              onChanged: ((value) {
                setState(() {});
              }),
              controller: _controller3,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_rounded,
                  color: VotoColors.primary,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                hintText: 'Confirm Password',
                fillColor: Color(0xFFF2F4F8),
                filled: true,
                suffixIcon: _controller3.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: (() => _clearTextField3(_controller3)),
                        icon: Icon(
                          Icons.clear,
                          color: Colors.black54,
                        ),
                      ),
              ),
              autofocus: false,
              obscureText: true,
              // style: const TextStyle(color: Color(0xFF141D3B)
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: VotoColors.primary,
              ),
              cursorColor: VotoColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
