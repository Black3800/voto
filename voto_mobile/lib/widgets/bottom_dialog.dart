import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class BottomDialog extends StatefulWidget {
  final String title;
  final MaterialColor accentColor;
  final Widget child;
  const BottomDialog(
      {Key? key,
      required this.title,
      required this.child,
      this.accentColor = VotoColors.indigo})
      : super(key: key);

  @override
  State<BottomDialog> createState() => _BottomDialogState();
}

class _BottomDialogState extends State<BottomDialog> {
  @override
  Widget build(BuildContext context) {
    double _deviceHeight = MediaQuery.of(context).size.height;
    return Wrap(
        // height: _deviceHeight,
        children: [
          Column(
            children: [
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
                    Text(widget.title,
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: widget.accentColor))
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: widget.child),
              const SizedBox(height: 20.0)
            ],
          )
        ]);
  }
}
