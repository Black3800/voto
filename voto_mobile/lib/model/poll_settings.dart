class PollSettings {
  bool multipleVote;
  bool anonymousVote;
  bool tiebreaker;
  bool multipleWinner;
  bool allowAdd;
  bool allowVoteOwnOption;
  bool showOptionOwner;
  int winnerCount;
  DateTime? closeDate;
  String? closeDateFormatted;

  PollSettings(
      {this.multipleVote = false,
      this.anonymousVote = false,
      this.tiebreaker = false,
      this.multipleWinner = false,
      this.allowAdd = false,
      this.allowVoteOwnOption = false,
      this.showOptionOwner = false,
      this.winnerCount = 2,
      this.closeDate,
      this.closeDateFormatted});

  PollSettings.fromJson(Map<dynamic, dynamic> json)
    : multipleVote = json['multiple_vote'],
      anonymousVote = json['anonymous_vote'],
      tiebreaker = json['tiebreaker'],
      multipleWinner = json['multiple_winner'],
      allowAdd = json['allow_add'],
      allowVoteOwnOption = json['allow_vote_own'],
      showOptionOwner = json['show_owner'],
      winnerCount = json['winner_count'],
      closeDate = DateTime.parse(json['close_date']);

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'multiple_vote': multipleVote,
    'anonymous_vote': anonymousVote,
    'tiebreaker': tiebreaker,
    'multiple_winner': multipleWinner,
    'allow_add': allowAdd,
    'allow_vote_own': allowVoteOwnOption,
    'show_owner': showOptionOwner,
    'winner_count': winnerCount,
    'close_date': closeDate?.toIso8601String()
  };
}
