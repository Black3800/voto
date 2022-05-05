import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class AddOptionItems extends StatefulWidget {
  final String name;
  const AddOptionItems({Key? key, required this.name}) : super(key: key);

  @override
  State<AddOptionItems> createState() => _AddOptionItemsState();
}

class _AddOptionItemsState extends State<AddOptionItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xFFF2F4F8),
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            child: Text(widget.name, style: GoogleFonts.inter()),
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
