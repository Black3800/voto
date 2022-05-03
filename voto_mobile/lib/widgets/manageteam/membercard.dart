import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class Membercard extends StatelessWidget {
  final String name;
  final bool isOwner;
  const Membercard({ Key? key, required this.name, this.isOwner = false }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontSize: 14),
              ),
              isOwner ? const Text(
                "Team owner",
                style: TextStyle(color: Color(0xff989898), fontSize: 12),
              ) : Container()
            ],
          ),
        )
      ],
    );
  }
}
