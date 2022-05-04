import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/widgets/addoption/add_option_body.dart';
import 'package:voto_mobile/widgets/addoption/add_option_button.dart';
import 'package:voto_mobile/widgets/confirm_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';

class AddOptionPage extends StatefulWidget {
  const AddOptionPage({Key? key}) : super(key: key);

  @override
  State<AddOptionPage> createState() => _AddOptionPageState();
}

class _AddOptionPageState extends State<AddOptionPage> {
  @override
  Widget build(BuildContext context) {
    return VotoScaffold(
        useMenu: false,
        title: 'Add option',
        titleContext: 'Integrated Project II',
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 48),
            child: Text(
              'Poll options',
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ),
          AddOptionBody(),
          AddOptionButton(),
          ConfirmButton(
              confirmText: 'Create',
              cancelText: 'Back',
              onConfirm: () {
                Navigator.popUntil(context, ModalRoute.withName('/team_page'));
              },
              onCancel: () {
                Navigator.pop(context);
              },
              height: 75.0)
        ]));
  }
}
