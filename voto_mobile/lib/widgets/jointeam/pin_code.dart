import 'package:flutter/material.dart';
import 'package:voto_mobile/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCode extends StatelessWidget {
  const PinCode({Key? key}) : super(key: key);

  final String requiredNumber = '1234';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pin Code.',
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'passcode',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(
                  height: 50.0,
                ),
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  onChanged: (value) {
                    print(value);
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 56,
                    fieldWidth: 54,
                    inactiveColor: VotoColors.white,
                    activeColor: VotoColors.indigo,
                  ),
                  onCompleted: (value) {
                    if (value == requiredNumber) {
                      print('success!');
                    } else {
                      print('invalid passcode');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
