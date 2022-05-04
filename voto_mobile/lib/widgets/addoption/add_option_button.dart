import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class AddOptionButton extends StatelessWidget {
  const AddOptionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return TextButton(
    //   style: TextButton.styleFrom(
    //     primary: VotoColors.secondary,
    //     onSurface: VotoColors.white,
    //     ),

    //   onPressed: null,
    //   child: Text('Add option',style: GoogleFonts.inter(fontSize:12),
    //   ),
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 48),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              primary: VotoColors.magenta,
              fixedSize: const Size(140, 36),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {},
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
                        color: VotoColors.white, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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