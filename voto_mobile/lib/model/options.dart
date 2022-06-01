import 'package:voto_mobile/model/choice.dart';

class Options {
  String? id;
  Map<dynamic, dynamic>? winner;
  Map<String, Choice>? choices;
  int? totalVote;

  Options({
    this.id,
    this.winner,
    this.choices,
    this.totalVote
  });

  Options.fromJson(Map<dynamic, dynamic> json)
    : winner = json['winner'] as Map<dynamic, dynamic>?,
      choices = (json['choices'] as Map<String, dynamic>?)
            ?.map((key, value) => MapEntry(key, Choice.fromJson(value))),
      totalVote = json['total_vote'] as int?;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'winner': winner,
    'choices': choices?.map((key, value) => MapEntry(key, value.toJson())),
    'total_vote': totalVote
  };
}