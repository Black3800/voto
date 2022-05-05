import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class TeamCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final Function()? onTap;
  const TeamCard(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  String? imageURL;

  Future<void> _getImageURL() async {
    imageURL = await FirebaseStorage.instance
        .refFromURL(widget.imagePath)
        .getDownloadURL();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getImageURL();
  }

  @override
  void didUpdateWidget(covariant TeamCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _getImageURL();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 15.0, right: 15.0),
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
          color: VotoColors.white,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            splashColor: VotoColors.indigo.shade100,
            onTap: widget.onTap,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(children: [
                CircleAvatar(
                  backgroundImage:
                      imageURL != null ? NetworkImage(imageURL ?? '') : null,
                  backgroundColor: VotoColors.indigo.shade300,
                  radius: 30.0,
                ),
                const SizedBox(width: 15.0),
                Text(
                  widget.title,
                  style: GoogleFonts.inter(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: VotoColors.indigo),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
