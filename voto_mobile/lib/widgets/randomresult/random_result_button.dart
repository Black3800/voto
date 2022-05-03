import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class RandomResultButton extends StatelessWidget {
  const RandomResultButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    double _deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      // width: _deviceWidth,
      // height: _deviceHeight * 0.15,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 200,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RandomResultSaveButton(),
            Padding(
              padding: const EdgeInsets.only(
                right: 20,
                left: 20,
              ),
            ),
            RandomResultShareButton(),
          ],
        ),
      ),
    );
  }
}

Widget RandomResultSaveButton() {
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
      'Save to device',
      style: TextStyle(
        color: VotoColors.indigo,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget RandomResultShareButton() {
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
      'Share',
      style: TextStyle(
        color: Color(0xFFF2F4F8),
       fontWeight: FontWeight.bold),
    ),
  );
}
