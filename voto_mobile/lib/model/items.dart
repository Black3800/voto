import 'package:voto_mobile/model/poll_settings.dart';

class Items {
  String? title;
  String? description;
  String? type;
  DateTime? lastModified;
  String? options;
  PollSettings? pollSettings;
  String? randomType;
  bool? closed;
  String? id;

  Items({
    this.id,
    this.title,
    this.description,
    this.type,
    this.lastModified,
    this.options,
    this.pollSettings,
    this.randomType,
    this.closed
  });

  Items.fromJson(Map<dynamic, dynamic> json)
    : title = json['title'],
      description = json['description'],
      type = json['type'],
      lastModified = json['last_modified'] != null ? DateTime.parse(json['last_modified']) : null,
      options = json['options'],
      pollSettings = json['poll_settings'] != null ? PollSettings.fromJson(json['poll_settings'] as Map<dynamic,dynamic>) : null,
      randomType = json['random_type'],
      closed = json['closed'];

  Items.fromItems(Items items)
    : id = items.id,
      title = items.title,
      description = items.description,
      type = items.type,
      lastModified = items.lastModified,
      options = items.options,
      pollSettings = items.pollSettings,
      randomType = items.randomType,
      closed = items.closed;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'title': title,
    'description': description,
    'type': type,
    'last_modified': lastModified?.toIso8601String(),
    'options': options,
    'poll_settings': pollSettings?.toJson(),
    'random_type': randomType,
    'closed': closed
  };
}