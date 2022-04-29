import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class RandomTask extends StatelessWidget {
  const RandomTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 35,
        right: 35,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Task 1 - Write introduction",
                style: GoogleFonts.inter(
                    fontSize: 14, fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(
              15.0,
            ),
            child: TextFormField(
              initialValue: 'Arny Anakin',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 2,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                fillColor: Color(0xFFF2F4F8),
                filled: true,
              ),
              readOnly: true,
            ),
          ),
          Text(
            "Task 2 - Write introduction",
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.all(
              15.0,
            ),
            child: TextFormField(
              initialValue: 'Tanny Panitnun',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 2,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                fillColor: Color(0xFFF2F4F8),
                filled: true,
              ),
              readOnly: true,
            ),
          ),
          Text(
            "Task 3 - Write introduction",
            style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.all(
              15.0,
            ),
            child: TextFormField(
              initialValue: 'Earth Chutirat',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                height: 2,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                ),
                fillColor: Color(0xFFF2F4F8),
                filled: true,
              ),
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }
}
