import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:google_fonts/google_fonts.dart';

class WinnerCard extends StatelessWidget {
  const WinnerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              blurRadius: 4.0,
              offset: Offset(2.0, 1.0))
        ],
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [-0.0073, 0.1979, 1],
          colors: [Color(0xFFFFA5A5), Color(0xFFEC368D), Color(0xFF440381)],
        ),
      ),
      padding: const EdgeInsets.all(20),
      width: 305,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          winnerText(),
          medalPic(),
        ],
      ),
    );
  }

  Widget medalPic() {
    return SizedBox(
      width: 47,
      height: 49,
      child: Image.asset(
        'assets/medal.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget winnerText() {
    return SizedBox(
      width: 218,
      height: 86,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 32,
          alignment: Alignment.topLeft,
          child: Text(
            'Winner',
            style: GoogleFonts.inter(
              color: VotoColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: 54,
          child: Column(
            children: [
              Text(
                '1. Salad',
                style: GoogleFonts.inter(
                  color: VotoColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '2. Pizza',
                style: GoogleFonts.inter(
                  color: VotoColors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
