import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/create_item/heading.dart';

class RandomTask extends StatefulWidget {
  final String text;
  const RandomTask({
    Key? key,
    required this.text
  }) : super(key: key);

  @override
  State<RandomTask> createState() => _RandomTaskState();
}

class _RandomTaskState extends State<RandomTask> {
  String? _currentMember = '';
  List<String> _memberNames = [];

  Future<void> _getMemberNames(BuildContext context) async {
    Team? currentTeam = Provider.of<PersistentState>(context, listen: false).currentTeam;
    if(currentTeam != null) {
      for (String uid in currentTeam.members.keys) {
        final data = await FirebaseDatabase.instance.ref('users/$uid/display_name').get();
        _memberNames.add(data.value as String);
      }
      WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {
        _memberNames = List.from(_memberNames);
        _currentMember = _memberNames[0];
      }));
    }
  }

  @override
  void initState() {
    super.initState();
    _getMemberNames(context);
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Heading(widget.text),
        const SizedBox(height: 15.0),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 84,
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: VotoColors.gray
                ),
                child: Center(
                  child: _currentMember != null
                          ? Text('$_currentMember',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                  fontSize: 20, fontWeight: FontWeight.bold))
                          : const CircularProgressIndicator()
                )
              )
            )
          ]),
      ],
    );
  }
}
