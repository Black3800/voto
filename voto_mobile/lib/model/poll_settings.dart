class PollSettings {
  bool multipleVote;
  bool anonymousVote;
  bool tiebreaker;
  bool multipleWinner;
  bool allowAdd;
  bool allowVoteOwnOption;
  bool showOptionOwner;
  int winnerCount;

  PollSettings(
      {this.multipleVote = false,
      this.anonymousVote = false,
      this.tiebreaker = false,
      this.multipleWinner = false,
      this.allowAdd = false,
      this.allowVoteOwnOption = false,
      this.showOptionOwner = false,
      this.winnerCount = 2});
}
