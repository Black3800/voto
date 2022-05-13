import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/model/users.dart';

class PersistentState extends ChangeNotifier {
  Users? _currentUser;
  Team? _currentTeam;
  Items? _currentItem;

  Users? get currentUser => _currentUser;
  Team? get currentTeam => _currentTeam;
  Items? get currentItem => _currentItem;

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
