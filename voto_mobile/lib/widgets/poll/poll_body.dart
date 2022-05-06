import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/poll/poll_checkbox.dart';
import 'package:voto_mobile/widgets/poll/poll_radio.dart';

class PollBody extends StatefulWidget {
  final bool isMultipleValue;
  const PollBody({Key? key, this.isMultipleValue = false}) : super(key: key);

  @override
  State<PollBody> createState() => _PollBodyState();
}

class _PollBodyState extends State<PollBody> {
  int _radioValue = -1;
  List<Choice> _choices = [];

  void _handleRadioChange(value) {
    setState(() => _radioValue = value ?? -1);
  }

  Future<void> _getChoices() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _choices = [
      Choice(
        text: 'Salad'
      ),
      Choice(
        text: 'Pizza'
      ),
      Choice(
        text: 'Bonchon'
      )
    ]);
  }

  @override
  void initState() {
    super.initState();
    _getChoices();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          editOptionButton(),
        ],
      ),
      ..._choices.map((e) => pollItem(e)),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: addOptionButton(),
      )
    ]);
  }

  Widget pollItem(Choice choice) {
    if (widget.isMultipleValue) {
      return  Poll_check(
                name: choice.text ?? ''
              );
    } else {
      return PollRadio(
              text: choice.text ?? '',
              value: _choices.indexOf(choice),
              groupValue: _radioValue,
              onChanged: _handleRadioChange,
            );
    }
  }

  Widget addOptionButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        primary: VotoColors.magenta,
        fixedSize: const Size(140, 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.add_circle,
              color: VotoColors.white,
            ),
          ),
          Expanded(
            child: Text(
              'Add option',
              style: GoogleFonts.inter(
                  color: VotoColors.white, fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget editOptionButton() {
    return TextButton(
      onPressed: () {},
      child: Text(
        'Edit',
        style: GoogleFonts.inter(
          color: VotoColors.indigo,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
