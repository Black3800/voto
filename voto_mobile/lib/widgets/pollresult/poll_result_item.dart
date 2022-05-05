import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:google_fonts/google_fonts.dart';

class PollResultItem extends StatelessWidget {
  const PollResultItem({
    required this.name,
    required this.voteCount, //ใช้ชั่วคราว จริงๆต้องใช้ object user
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String name;
  final Function()? onTap;
  final int voteCount;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(children: [
          itemName(),
          sliderVoteCount(context),
          voterImage(),
        ]),
      ),
    );
  }

  Widget itemName() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        name,
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
                value: voteCount.toDouble(),
                max: 35,
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
            voteCount.toString(),
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

  Widget voterImage() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(0),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        voterImageDefault(),
        voterImageDefault(),
        voterImageDefault(),
        voterImageDefault(),
        voterImageDefault(),
        (voteCount > 5 ? voterImageAddition() : Container()),
      ]),
    );
  }

  Widget voterImageDefault() {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      alignment: Alignment.center,
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFF2F4F8),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/user_profile_test.jpg'),
        ),
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
          Text((voteCount - 5).toString(),
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
