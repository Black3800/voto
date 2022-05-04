import 'package:flutter/material.dart';
import 'package:voto_mobile/widgets/manageteamowner/kick_button.dart';

class Membercard extends StatelessWidget {
  final String name;
  final bool isOwner;
  final bool kickable;
  const Membercard(
      {Key? key,
      required this.name,
      this.isOwner = false,
      this.kickable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 14),
                ),
                isOwner
                    ? const Text(
                        "Team owner",
                        style:
                            TextStyle(color: Color(0xff989898), fontSize: 12),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        kickable ? const KickButton() : Container()
      ],
    );
  }
}
