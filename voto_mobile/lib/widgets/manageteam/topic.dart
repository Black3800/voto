import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class Topic extends StatelessWidget {
  String topic;
  Topic(this.topic);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        topic,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
