class Users {
  final Map<dynamic, dynamic> joined_teams;
  const Users({
    required this.joined_teams
  });

  Users.fromJson(Map<dynamic, dynamic> json)
    : joined_teams = json['joined_teams'] as Map<dynamic, dynamic>;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'joined_teams': joined_teams.toString()
  };
}