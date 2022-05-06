import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class AddOptionButton extends StatelessWidget {
  const AddOptionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClickOptionButton();
  }
}

class ClickOptionButton extends StatelessWidget {
  const ClickOptionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void confirmAddPopup() {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            'Add your option',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          content: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Type your option in here...',
            ),
            style:
                GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 48),
            child: ElevatedButton(
              onPressed: () {
                confirmAddPopup();
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                primary: VotoColors.magenta,
                fixedSize: const Size(140, 36),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.add_circle,
                      color: VotoColors.white,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Add option',
                      style: GoogleFonts.inter(
                          color: VotoColors.white,
                          fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// Widget AddOptionButton() {
//   return ElevatedButton(
//     style: ElevatedButton.styleFrom(
//       padding: EdgeInsets.zero,
//       primary: VotoColors.magenta,
//       fixedSize: const Size(140, 36),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//     ),
//     onPressed: () {},
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children:  [
//         Padding(
//           padding: EdgeInsets.only(left: 8.0),
//           child: Icon(
//             Icons.add_circle,
//             color: VotoColors.white,
//           ),
//         ),

//         Expanded(
//           child: Text(
//             'Add option',
//             style: GoogleFonts.inter(
//                 color: VotoColors.white, fontWeight: FontWeight.normal),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     ),
//   );
// }


