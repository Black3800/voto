import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:voto_mobile/model/users.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/widgets/image_input.dart';

class PollResultItem extends StatefulWidget {
  const PollResultItem({
    required this.text,
    required this.voteCount,
    required this.totalVote,
    required this.onTap,
    this.voters,
    this.owner,
    this.showVoter = true,
    Key? key,
  }) : super(key: key);

  final String text;
  final String? owner;
  final Function({
    required BuildContext context,
    required String text,
    required int voteCount,
    required List<Users> voters,
    String? owner
  })? onTap;
  final int voteCount;
  final int totalVote;
  final bool showVoter;
  final Map<dynamic, dynamic>? voters;

  @override
  State<PollResultItem> createState() => _PollResultItemState();
}

class _PollResultItemState extends State<PollResultItem> {
  late Future<List<Users>> _votersInfo;
  late Future<String?> _ownerName;

  Future<List<Users>> _getVotersInfo() async {
    if (widget.voters != null) {
      List<Users> _newVotersInfo = [];
      for (String uid in widget.voters!.keys) {
        final snapshot = await FirebaseDatabase.instance.ref('users/$uid').get();
        final data = Users.fromJson(snapshot.value as Map<dynamic,dynamic>);
        _newVotersInfo.add(data);
      }
      return Future.value(_newVotersInfo);
    } else {
      return Future.value([]);
    }
  }

  Future<String?> _getOwnerName() async {
    if (widget.owner != null) {
      final snapshot = await FirebaseDatabase.instance.ref('users/${widget.owner}/display_name').get();
      return snapshot.value as String?;
    } else {
      return Future.value(null);
    }
  }

  @override
  void initState() {
    super.initState();
    _votersInfo = _getVotersInfo();
    _ownerName = _getOwnerName();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap != null ? () async {
        List<Users> _voters = await _votersInfo;
        String? _owner = await _ownerName;
        widget.onTap!(
          context: context,
          text: widget.text,
          owner: _owner,
          voteCount: widget.voteCount,
          voters: _voters
        );
      } : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          itemtext(),
          sliderVoteCount(context),
          if(widget.showVoter) voterImages(),
        ]),
      ),
    );
  }

  Widget itemtext() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        widget.text,
        style: GoogleFonts.inter(
          color: VotoColors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget sliderVoteCount(context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SliderTheme(
              child: Slider(
                value: widget.voteCount.toDouble(),
                max: widget.totalVote.toDouble(),
                min: 0,
                activeColor: VotoColors.indigo,
                inactiveColor: const Color(0xFFF2F4F8),
                onChanged: (double value) {},
              ),
              data: SliderTheme.of(context).copyWith(
                  overlayShape: SliderComponentShape.noThumb,
                  trackHeight: 4,
                  thumbColor: Colors.transparent,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 0.0)),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.voteCount.toString(),
            style: GoogleFonts.inter(
              color: VotoColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Widget voterImages() {
    return FutureBuilder(
      future: _votersInfo,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final votersInfo = snapshot.data as List<Users>;
          return Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.zero,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                ...votersInfo.map((e) => voterImageDefault(e.img)),
                (widget.voteCount > 5 ? voterImageAddition() : Container()),
              ]),
            );
        } else {
          return SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 1.0,
              valueColor: AlwaysStoppedAnimation<Color>(VotoColors.gray.shade900),
            )
          );
        }
      }
    );
  }

  Widget voterImageDefault(image) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: ImageInput(
        image: image,
        radius: 24,
        readOnly: true,
        showLoadingStatus: false,
      ),
    );
  }

  Widget voterImageAddition() {
    return Container(
      alignment: Alignment.center,
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFF2F4F8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add,
            size: 5,
          ),
          Text((widget.voteCount - 5).toString(),
              style: GoogleFonts.inter(
                color: VotoColors.black,
                fontSize: 8,
                fontWeight: FontWeight.w300,
              ))
        ],
      ),
    );
  }
}
