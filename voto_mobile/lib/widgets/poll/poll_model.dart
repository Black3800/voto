import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class PollItem extends StatefulWidget {
  const PollItem({
    required this.name,
    required this.isVoted,
    Key? key,
  }) : super(key: key);

  final String name;
  final bool isVoted;

  @override
  State<PollItem> createState() => _PollItemState();
}

class _PollItemState extends State<PollItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
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
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: widget.isVoted
                    ? const Icon(
                        Icons.check_box,
                        color: VotoColors.indigo,
                        size: 25,
                      )
                    : const Icon(
                        Icons.check_box_outline_blank,
                        color: VotoColors.indigo,
                        size: 25,
                      ),
              ),
              const SizedBox(
                width: 35,
              ),
              Expanded(
                child: Text(
                  widget.name,
                  style: Theme.of(context).textTheme.bodyText1),
              ),
            ]),
          ),
          onTap: () {  },
        );
  }
}
