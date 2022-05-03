import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/bottom_dialog.dart';
import 'package:voto_mobile/widgets/manageteam/passcode.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class JoinTeam extends StatefulWidget {
  const JoinTeam({Key? key}) : super(key: key);

  @override
  State<JoinTeam> createState() => _JoinTeamState();
}

class _JoinTeamState extends State<JoinTeam> {
  // var _controller = TextEditingController();

  // void _clearTextField(TextEditingController controller) {
  //   // Clear everything in the text field
  //   controller.clear();
  //   // Call setState to update the UI
  //   setState(() {});
  // }

  void showEnterPasscodeDialog() {
    Navigator.pop(context);
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return BottomDialog(
          title: "Enter passcode",
          height: 0.65,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("The following team requires passcode to join",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.merge(const TextStyle(color: VotoColors.black))),
              const SizedBox(height: 15.0),
              const Center(
                  child: CircleAvatar(
                      backgroundImage: AssetImage('dummy/misc2.jpg'),
                      radius: 50.0)),
              const SizedBox(height: 15.0),
              Center(
                child: Text("Integrated Project II",
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.merge(const TextStyle(color: VotoColors.black))),
              ),
              const SizedBox(height: 15.0),
              Text("Passcode",
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      ?.merge(const TextStyle(color: VotoColors.black))),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Pass()],
              ),
              const SizedBox(height: 30.0),
              WideButton(
                  text: 'Join',
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      },
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomDialog(
      title: 'Join team',
      child: ListView(
        children: [
          Text("Enter team's join code or the link you received",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.merge(const TextStyle(color: VotoColors.black))),
          const SizedBox(height: 15.0),
          Text("Join code",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.merge(const TextStyle(color: VotoColors.black))),
          const SizedBox(height: 15.0),
          const SimpleTextInput(
            accentColor: VotoColors.indigo,
            max: 6,
          ),
          const SizedBox(height: 30.0),
          WideButton(text: 'Join', onPressed: showEnterPasscodeDialog)
        ],
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.only(
    //     top: 15,
    //     left: 15,
    //     right: 15,
    //     bottom: 20,
    //   ),
    //   child: Column(
    //     children: [
    //       Row(
    //         children: [
    //           IconButton(
    //             icon: const Icon(Icons.clear, color: VotoColors.primary),
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(
    //               right: 40,
    //             ),
    //             child: Text(
    //               "Join Team",
    //               style: GoogleFonts.inter(
    //                   fontSize: 20,
    //                   color: VotoColors.primary,
    //                   fontWeight: FontWeight.w500),
    //               // textAlign: TextAlign.center,
    //             ),
    //           )
    //         ],
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(
    //           top: 10,
    //           left: 10,
    //         ),
    //         child: Row(
    //           children: [
    //             Text(
    //               "Enter team’s join code or the link you received",
    //               style: GoogleFonts.inter(
    //                   fontSize: 14,
    //                   color: VotoColors.primary,
    //                   fontWeight: FontWeight.normal),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(
    //           top: 25,
    //           left: 10,
    //         ),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 Text(
    //                   "Join Code",
    //                   style: GoogleFonts.inter(
    //                       fontSize: 14,
    //                       color: VotoColors.primary,
    //                       fontWeight: FontWeight.bold),
    //                   textAlign: TextAlign.start,
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(
    //           top: 25,
    //         ),
    //         child: TextFormField(
    //           onChanged: ((value) {
    //             setState(() {});
    //           }),
    //           controller: _controller,
    //           decoration: InputDecoration(
    //             border: OutlineInputBorder(
    //               borderSide: BorderSide.none,
    //               borderRadius: BorderRadius.all(
    //                 Radius.circular(18),
    //               ),
    //             ),
    //             hintText: 'Aa',
    //             fillColor: Color(0xFFF2F4F8),
    //             filled: true,
    //             suffixIcon: _controller.text.isEmpty
    //                 ? null
    //                 : IconButton(
    //                     onPressed: (() => _clearTextField(_controller)),
    //                     icon: Icon(
    //                       Icons.clear,
    //                       color: Colors.black54,
    //                     ),
    //                   ),
    //           ),
    //           autofocus: false,
    //           obscureText: true,
    //           // style: const TextStyle(color: Color(0xFF141D3B)
    //           style: GoogleFonts.inter(
    //             fontSize: 14,
    //             fontWeight: FontWeight.normal,
    //             color: VotoColors.primary,
    //           ),

    //           cursorColor: VotoColors.primary,
    //         ),
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.only(
    //           top: 30,
    //         ),
    //       ),
    //       ElevatedButton(
    //         onPressed: () {
    //           // Navigator.pushNamed(context, '/join_team');
    //           Navigator.pop(context);
    //           showModalBottomSheet<void>(
    //             isScrollControlled: true,
    //             context: context,
    //             builder: (BuildContext context) {
    //               return BottomDialog(
    //                 title: "Enter passcode",
    //                 height: 0.65,
    //                 child: ListView(
    //                   // crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text("The following team requires passcode to join",
    //                         style: Theme.of(context).textTheme.bodyText1?.merge(
    //                             const TextStyle(color: VotoColors.black))),
    //                     const SizedBox(height: 15.0),
    //                     const Center(
    //                         child: CircleAvatar(
    //                             backgroundImage: AssetImage('dummy/misc2.jpg'),
    //                             radius: 50.0)),
    //                     const SizedBox(height: 15.0),
    //                     Center(
    //                       child: Text("Integrated Project II",
    //                           style: Theme.of(context).textTheme.headline2?.merge(
    //                               const TextStyle(color: VotoColors.black))),
    //                     ),
    //                     const SizedBox(height: 15.0),
    //                     Text("Passcode",
    //                         style: Theme.of(context).textTheme.headline3?.merge(
    //                             const TextStyle(color: VotoColors.black))),
    //                     const SizedBox(height: 15.0),
    //                     Row(mainAxisAlignment: MainAxisAlignment.center, children: const [Pass()],),
    //                     const SizedBox(height: 30.0),
    //                     WideButton(
    //                         text: 'Join',
    //                         onPressed: () {
    //                           Navigator.pop(context);
    //                         }),
    //                   ],
    //                 ),
    //               );
    //             },
    //             shape: const RoundedRectangleBorder(
    //                 borderRadius:
    //                     BorderRadius.vertical(top: Radius.circular(20.0))),
    //           );
    //         },
    //         style: ElevatedButton.styleFrom(
    //           padding: const EdgeInsets.all(0),
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(47.0),
    //           ),
    //         ),
    //         child: Ink(
    //           decoration: const BoxDecoration(
    //             color: VotoColors.primary,
    //             borderRadius: BorderRadius.all(Radius.circular(50.0)),
    //           ),
    //           child: Container(
    //             padding: const EdgeInsets.all(8),
    //             width: MediaQuery.of(context).size.width * 1,
    //             height: 35,
    //             child: Text(
    //               "Join",
    //               style: GoogleFonts.inter(fontSize: 14),
    //               textAlign: TextAlign.center,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
