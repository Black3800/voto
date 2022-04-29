import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class JoinTeam extends StatefulWidget {
  const JoinTeam({Key? key}) : super(key: key);

  @override
  State<JoinTeam> createState() => _JoinTeamState();
}

class _JoinTeamState extends State<JoinTeam> {
  var _controller = TextEditingController();

  void _clearTextField(TextEditingController controller) {
    // Clear everything in the text field
    controller.clear();
    // Call setState to update the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.clear, color: VotoColors.primary),
                onPressed: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 40,
                ),
                child: Text(
                  "Enter passcode",
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      color: VotoColors.primary,
                      fontWeight: FontWeight.w500),
                  // textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 10,
            ),
            child: Row(
              children: [
                Text(
                  "The following team requires passcode to join",
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      color: VotoColors.black,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/dummy/misc2.jpg'),
              radius: 30.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Center(
              child: Text(
                "Integrated Project II",
                style: GoogleFonts.inter(
                    fontSize: 14,
                    color: VotoColors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 25,
              left: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Passcode",
                      style: GoogleFonts.inter(
                          fontSize: 14,
                          color: VotoColors.primary,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/enter_passcode');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(47.0),
              ),
            ),
            child: Ink(
              decoration: const BoxDecoration(
                color: VotoColors.primary,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
              ),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width * 1,
                height: 35,
                child: Text(
                  "Join",
                  style: GoogleFonts.inter(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
