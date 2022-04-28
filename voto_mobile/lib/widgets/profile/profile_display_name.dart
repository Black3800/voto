import 'package:flutter/material.dart';

class ProfileDisplayName extends StatelessWidget {
  const ProfileDisplayName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: _deviceHeight * 0.05,
      child: const Text(
        'Tanny Panitnun',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
