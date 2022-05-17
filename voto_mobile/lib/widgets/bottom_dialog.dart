import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class BottomDialog extends StatefulWidget {
  final String title;
  final String? titleContext;
  final MaterialColor accentColor;
  final Widget child;
  final double height;
  const BottomDialog(
      {Key? key,
      required this.title,
      required this.child,
      this.accentColor = VotoColors.indigo,
      this.height = 0.75,
      this.titleContext})
      : super(key: key);

  @override
  State<BottomDialog> createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * widget.height + MediaQuery.of(context).viewInsets.bottom,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.close),
                  iconSize: 32.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  splashRadius: 24.0,
                  color: widget.accentColor),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: widget.accentColor)),
                    if (widget.titleContext != null)
                      Text('${widget.titleContext}',
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                              fontSize: 12.0, color: VotoColors.black))
                  ],
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: widget.child),
        ),
        const SizedBox(height: 20.0)
      ]),
    );
  }
}
