import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class PersistentState extends ChangeNotifier {
  String _teamName = '';

  String get teamName => _teamName;

  void updateTeamName(String newTeamName) {
    _teamName = newTeamName;
  }
}
