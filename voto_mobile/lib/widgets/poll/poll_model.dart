import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class PollItem extends StatefulWidget {
  PollItem({
    required this.name,
    required this.voted,
    Key? key,
  }) : super(key: key);

  String name;
  bool voted;

  @override
  State<PollItem> createState() => _PollItemState();
}

class _PollItemState extends State<PollItem> {
  @override
  Widget build(BuildContext context) {
    return voteOptionCard();
  }

  Widget voteOptionCard() {
    return Container(
      decoration: const BoxDecoration(
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
      height: 57,
      padding: const EdgeInsets.all(0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Material(
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: widget.voted
                  ? const Icon(
                      Icons.check_box,
                      color: VotoColors.indigo,
                      size: 20,
                    )
                  : const Icon(
                      Icons.check_box_outline_blank,
                      color: VotoColors.indigo,
                      size: 20,
                    ),
            ),
          ),
        ),
        const SizedBox(
          width: 37,
        ),
        Text(
          widget.name,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
        ),
      ]),
    );
  }
}
