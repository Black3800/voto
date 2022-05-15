import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class PollNull extends StatelessWidget {
  final String text;
  final bool isEditing;
  final Function()? onChangeAttempted;
  final Function()? onDeleted;
  const PollNull(
      {Key? key,
      required this.text,
      this.isEditing = false,
      this.onChangeAttempted,
      this.onDeleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: VotoColors.gray,
        border: Border(
          top: BorderSide(
            width: 1,
            color: VotoColors.black.shade50,
          ),
          bottom: BorderSide(
            width: 1,
            color: VotoColors.black.shade50,
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
                  textStyle: Theme.of(context).textTheme.bodyText1,
                  color: VotoColors.black.shade400
              ),
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
          tristate: true,
          value: null,
          onChanged: (_) => onChangeAttempted?.call(),
          activeColor: VotoColors.black.shade200,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0),
        ),
      ),
    );
  }
}
