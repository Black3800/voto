class Choice {
  String? id;
  String? text;
  int? voteCount;
  Map<dynamic, dynamic>? votedBy;
  bool? win;
  String? assignee;
  Choice({
    this.text,
    this.voteCount,
    this.votedBy,
    this.win,
    this.assignee
  });

  Choice.fromJson(Map<dynamic, dynamic> json)
    : text = json['text'],
      voteCount = json['vote_count'],
      votedBy = json['voted_by'] as Map<dynamic, dynamic>?,
      win = json['win'],
      assignee = json['assignee'];

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'text': text,
    'vote_count': voteCount,
    'voted_by': votedBy.toString(),
    'win': win,
    'assignee': assignee
  };
}