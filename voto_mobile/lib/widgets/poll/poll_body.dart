import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/poll/poll_checkbox.dart';
import 'package:voto_mobile/widgets/poll/poll_model.dart';

class PollBody extends StatefulWidget {
  const PollBody({Key? key}) : super(key: key);

  @override
  State<PollBody> createState() => _PollBodyState();
}

class _PollBodyState extends State<PollBody> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          editOptionButton(),
        ],
      ),
      Poll_check(name: 'Salad'),
      Poll_check(name: 'Pizza'),
      Poll_check(name: 'Bonchon'),
      Poll_check(name: 'KFC'),
      Poll_check(name: 'Sushi'),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: addOptionButton(),
      )
    ]);
  }

  Widget addOptionButton() {
    return ElevatedButton(
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
        children:  [
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
    );
  }

  Widget editOptionButton() {
    return TextButton(
      onPressed: () {},
      child: Text(
        'Edit',
        style: GoogleFonts.inter(
          color: VotoColors.indigo,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
