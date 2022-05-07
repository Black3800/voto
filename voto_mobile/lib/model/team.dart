class Team {
  final String img;
  final String name;
  final String owner;
  final Map<dynamic, dynamic> members;
  String? id;
  String? passcode;

  Team({
    required this.img,
    required this.name,
    required this.owner,
    required this.members,
    this.id = '',
    this.passcode
  });

  Team.fromJson(Map<dynamic, dynamic> json)
    : img = json['img'] as String,
      name = json['name'] as String,
      members = json['members'] as Map<dynamic, dynamic>,
      owner = json['owner'] as String,
      passcode = json['passcode'] as String?;

  Map<dynamic, dynamic> toJson( )=> <dynamic, dynamic>{
    'img': img,
    'name': name,
    'owner': owner,
    'members': members,
    'passcode': passcode
  };
}