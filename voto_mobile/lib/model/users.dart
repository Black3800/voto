class Users {
  final String? displayName;
  final String? email;
  final String? img;
  final Map<dynamic, dynamic>? joinedTeams;
  const Users({
    this.displayName,
    this.email,
    this.img,
    this.joinedTeams
  });

  Users.fromJson(Map<dynamic, dynamic> json)
    : displayName = json['display_name'],
      email = json['email'],
      img = json['img'],
      joinedTeams = json['joined_teams'] as Map<dynamic, dynamic>?;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'display_name': displayName,
    'email': email,
    'img': img,
    'joined_teams': joinedTeams.toString()
  };
}