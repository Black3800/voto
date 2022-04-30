import 'package:flutter/material.dart';

class PollHeader extends StatelessWidget {
  const PollHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        pollTitle(),
        const SizedBox(height: 20),
        pollDetail(),
      ],
    );
  }

  Widget pollTitle() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Vote for today’s lunch',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Text(
            'Closing on 23 April 2022, 10:00',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }

  Widget pollDetail() {
    return const SizedBox(
      height: 34,
      child: Text(
        'Let’s order some food for lunch today. Pick two choices you would like as your lunch!',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),
    );
  }
}
