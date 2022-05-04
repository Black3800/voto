class Users {
  final String? displayName;
  final String? img;
  final Map<dynamic, dynamic>? joinedTeams;
  const Users({
    this.displayName,
    this.img,
    this.joinedTeams
  });

  Users.fromJson(Map<dynamic, dynamic> json)
    : displayName = json['display_name'],
      img = json['img'],
      joinedTeams = json['joined_teams'] as Map<dynamic, dynamic>?;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'display_name': displayName,
    'img': img,
    'joined_teams': joinedTeams.toString()
  };
}