import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/image_input.dart';

class TeamCard extends StatefulWidget {
  final String id;
  const TeamCard({ Key? key, required this.id}) : super(key: key);

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {

  late Future<Team?> team;

  Future<Team?> _getTeam() async {
    final snapshot = await FirebaseDatabase.instance.ref('teams/${widget.id}').get();
    if (snapshot.exists) {
      final data = snapshot.value as Map;
      final team = Team.fromJson(data);
      team.id = widget.id;
      return team;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    team = _getTeam();
  }

  @override
  void didUpdateWidget(covariant TeamCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    team = _getTeam();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: team,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final _team = snapshot.data as Team;
          return Container(
            padding: const EdgeInsets.only(
                top: 8.0, bottom: 8.0, left: 15.0, right: 15.0),
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
                  onTap: () {
                    Provider.of<PersistentState>(context, listen: false).updateTeam(_team);
                    Navigator.of(context).pushNamed('/team_page');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      ImageInput(
                        image: _team.img,
                        radius: 56,
                        readOnly: true,
                        showLoadingStatus: false,
                        showBorder: true,
                      ),
                      const SizedBox(width: 15.0),
                      Expanded(
                        child: Text(
                          _team.name,
                          style: GoogleFonts.inter(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                              color: VotoColors.indigo),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
