import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/poll/poll_model.dart';

class PollBody extends StatefulWidget {
  const PollBody({Key? key}) : super(key: key);

  @override
  State<PollBody> createState() => _PollBodyState();
}

class _PollBodyState extends State<PollBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            editOptionButton(),
          ],
        ),
        Column(
          children: [
            PollItem(name: 'Salad', voted: true),
            PollItem(name: 'Pizza', voted: true),
            PollItem(name: 'Bonchon', voted: false)
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            addOptionButton(),
          ],
        )
      ],
    );
  }

  Widget addOptionButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: VotoColors.magenta,
        fixedSize: const Size(120, 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.add_circle,
            color: VotoColors.white,
          ),
          Text(
            'Add option',
            style: TextStyle(
                color: VotoColors.white, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget editOptionButton() {
    return TextButton(
      onPressed: () {},
      child: const Text(
        'Edit',
        style: TextStyle(
          color: VotoColors.indigo,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
