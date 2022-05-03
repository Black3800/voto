import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

import 'kick_button.dart';

class Member extends StatelessWidget {
  String name;
  Member(this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 305,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    // border: Border.all(width: 1, color: VotoColors.primary),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/user_profile_test.jpg'),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          Padding(
            child: KickButton(),
            padding: const EdgeInsets.only(left: 15),
          ),
        ],
      ),
    );
  }
}
