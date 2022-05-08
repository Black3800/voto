import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class AddOptionItem extends StatefulWidget {
  final String text;
  final bool isEditing;
  final Function()? onDelete;
  const AddOptionItem({
    Key? key,
    required this.text,
    this.isEditing = false,
    this.onDelete
  }) : super(key: key);

  @override
  State<AddOptionItem> createState() => _AddOptionItemState();
}

class _AddOptionItemState extends State<AddOptionItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: VotoColors.gray,
                ),
                bottom: BorderSide(
                  width: 1,
                  color: VotoColors.gray,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.text,
                    style: GoogleFonts.inter(
                        textStyle: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
                Visibility(
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: VotoColors.danger,
                    ),
                    onPressed: widget.onDelete,
                  ),
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: widget.isEditing
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
