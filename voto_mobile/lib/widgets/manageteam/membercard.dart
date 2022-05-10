import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/widgets/image_input.dart';
import 'package:voto_mobile/widgets/manageteamowner/kick_button.dart';

class Membercard extends StatelessWidget {
  final String name;
  final String image;
  final bool isOwner;
  final bool kickable;
  const Membercard(
      {Key? key,
      required this.name,
      required this.image,
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
          child: ImageInput(
            image: image,
            radius: 40,
            readOnly: true,
            showLoadingStatus: false,
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
                  style: GoogleFonts.inter(fontSize: 14),
                ),
                isOwner
                    ? Text(
                        "Team owner",
                        style:
                            GoogleFonts.inter(color: const Color(0xff989898), fontSize: 12),
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
