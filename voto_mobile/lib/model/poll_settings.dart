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

  PollSettings(
      {this.multipleVote = false,
      this.anonymousVote = false,
      this.tiebreaker = false,
      this.multipleWinner = false,
      this.allowAdd = false,
      this.allowVoteOwnOption = false,
      this.showOptionOwner = false,
      this.winnerCount = 2,
      this.closeDate});

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
    'multipleVote': multipleVote,
    'anonymousVote': anonymousVote,
    'tiebreaker': tiebreaker,
    'multipleWinner': multipleWinner,
    'allowAdd': allowAdd,
    'allowVoteOwnOption': allowVoteOwnOption,
    'showOptionOwner': showOptionOwner,
    'winnerCount': winnerCount,
    'close_date': closeDate?.toIso8601String()
  };
}
