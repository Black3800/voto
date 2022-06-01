import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/model/users.dart';

class PersistentState extends ChangeNotifier {
  Users? _currentUser;
  Team? _currentTeam;
  Items? _currentItem;
  bool _isCreatingItem = false;
  String? _latestTeamLeft;

  Users? get currentUser => _currentUser;
  Team? get currentTeam => _currentTeam;
  Items? get currentItem => _currentItem;
  bool get isCreatingItem => _isCreatingItem;
  String? get latestTeamLeft => _latestTeamLeft;

  set isCreatingItem(bool value) {
    _isCreatingItem = value;
    notifyListeners();
  }

  set latestTeamLeft(String? teamId) {
    _latestTeamLeft = teamId;
    notifyListeners();
  }

  void updateUser(Users? newUser) {
    _currentUser = newUser;
    notifyListeners();
  }

  void updateTeam(Team? newTeam) {
    _currentTeam = newTeam;
    notifyListeners();
  }

  void updateItem(Items? newItem) {
    _currentItem = newItem;
  }

  void disposeUser() {
    _currentUser = null;
  }

  void disposeTeam() {
    _currentTeam = null;
  }

  void disposeItem() {
    _currentItem = null;
  }

  @override
  void dispose() {
    disposeUser();
    disposeTeam();
    disposeItem();
    super.dispose();
  }
}
