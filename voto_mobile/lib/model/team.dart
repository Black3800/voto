class Team {
  final String img;
  final String name;
  final String id;

  const Team({
    required this.img,
    required this.name,
    this.id = ''
  });

  Team.fromJson(Map<dynamic, dynamic> json)
    : img = json['img'] as String,
      name = json['name'] as String,
      id = '';

  Map<dynamic, dynamic> toJson( )=> <dynamic, dynamic>{
    'img': img,
    'name': name,
    'id': ''
  };
}