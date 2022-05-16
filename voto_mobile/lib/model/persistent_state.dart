import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/model/users.dart';

class PersistentState extends ChangeNotifier {
  Users? _currentUser;
  Team? _currentTeam;
  Items? _currentItem;
  List<Choice>? _currentMembers;
  bool _isCreatingItem = false;

  Users? get currentUser => _currentUser;
  Team? get currentTeam => _currentTeam;
  Items? get currentItem => _currentItem;
  List<Choice>? get currentMembers => _currentMembers;
  bool get isCreatingItem => _isCreatingItem;

  set isCreatingItem(bool value) {
    _isCreatingItem = value;
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

  void updateMembers(List<Choice>? newMembers) {
    _currentMembers = newMembers;
    notifyListeners();
  }

  void disposeUser() {
    _currentUser = null;
  }

  void disposeTeam() {
    _currentTeam = null;
    disposeMembers();
  }

  void disposeItem() {
    _currentItem = null;
  }

  void disposeMembers() {
    _currentMembers = null;
  }

  @override
  void dispose() {
    disposeUser();
    disposeTeam();
    disposeItem();
    super.dispose();
  }
}
