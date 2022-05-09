import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class PollCheckbox extends StatelessWidget {
  final String text;
  final bool isChecked;
  final bool isEditing;
  final Function(bool?)? onChanged;
  final Function()? onDeleted;
  const PollCheckbox({
    Key? key,
    required this.text,
    required this.isChecked,
    this.isEditing = false,
    this.onChanged,
    this.onDeleted
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(0xFFF2F4F8),
          ),
          bottom: BorderSide(
            width: 1,
            color: Color(0xFFF2F4F8),
          ),
        ),
      ),
      child: Theme(
        data: ThemeData(
          checkboxTheme: CheckboxThemeData(
            side: const BorderSide(width: 1, color: VotoColors.indigo),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: CheckboxListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: GoogleFonts.inter(
                  textStyle: Theme.of(context).textTheme.bodyText1),
            ),
          ),
          secondary: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: isEditing
                  ? IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: VotoColors.danger,
                      ),
                      onPressed: onDeleted,
                    )
                  : const SizedBox()),
          controlAffinity: ListTileControlAffinity.leading,
          value: isChecked,
          onChanged: onChanged,
          activeColor: VotoColors.indigo,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        ),
      ),
    );
  }
}
