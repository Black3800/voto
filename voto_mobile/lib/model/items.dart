import 'package:voto_mobile/model/poll_settings.dart';

class Items {
  String? title;
  String? description;
  String? type;
  DateTime? lastModified;
  String? options;
  PollSettings? pollSettings;
  String? randomType;

  Items({
    this.title,
    this.description,
    this.type,
    this.lastModified,
    this.options,
    this.pollSettings,
    this.randomType
  });

  Items.fromJson(Map<dynamic, dynamic> json)
    : title = json['title'],
      description = json['description'],
      type = json['type'],
      lastModified = DateTime.parse(json['last_modified']),
      options = json['options'],
      pollSettings = PollSettings.fromJson(json['poll_settings']),
      randomType = json['random_type'];

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'title': title,
    'description': description,
    'type': type,
    'lastModified': lastModified?.toIso8601String(),
    'options': options,
    'pollSettings': pollSettings,
    'randomType': randomType
  };
}