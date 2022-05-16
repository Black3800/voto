import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/image_input.dart';

class ProfileCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final Function()? onTap;
  const ProfileCard(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: VotoColors.indigo.shade400),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 5.0,
                offset: Offset(1.0, 2.0))
          ],
          color: VotoColors.indigo,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            splashColor: VotoColors.indigo.shade100,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                ImageInput(
                  image: imagePath,
                  radius: 60.0,
                  readOnly: true,
                  showLoadingStatus: false,
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: VotoColors.white),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 32.0,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
