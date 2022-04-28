import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: _deviceWidth,
      height: _deviceHeight * 0.15,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          profileCancleButton(),
          profileSaveButton(),
        ],
      ),
    );
  }
}

Widget profileSaveButton() {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      onSurface: (VotoColors.indigo),
      fixedSize: const Size(132, 35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    onPressed: () {},
    child: const Text(
      'Save',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget profileCancleButton() {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: const Color(0xFFF2F4F8),
      fixedSize: const Size(132, 35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    onPressed: () {},
    child: const Text(
      'Cancle',
      style: TextStyle(color: VotoColors.indigo, fontWeight: FontWeight.bold),
    ),
  );
}
