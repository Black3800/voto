import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:voto_mobile/model/team.dart';

class PersistentState extends ChangeNotifier {
  Team? _currentTeam;

  Team? get currentTeam => _currentTeam;

  void updateTeam(Team newTeam) {
    _currentTeam = newTeam;
  }
}
