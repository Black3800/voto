import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:voto_mobile/model/poll_settings.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/create_item/heading.dart';
import 'package:voto_mobile/widgets/create_item/simple_checkbox.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';

class PollSettingsWidgets {
  DateTime selectedDate;
  TimeOfDay selectedTime;
  PollSettings pollSettings;
  final Function()? onChanged;
  final TextEditingController multipleWinnerController;
  PollSettingsWidgets({
    required this.selectedDate,
    required this.selectedTime,
    required this.pollSettings,
    required this.multipleWinnerController,
    this.onChanged
  });

  Widget datePickerButton(context) => OutlinedButton(
        onPressed: () => _selectDate(context),
        child: Row(children: [
          const Icon(
            Icons.event,
            size: 24.0,
          ),
          const SizedBox(width: 10.0),
          Text(DateFormat('yMMMMd').format(selectedDate))
        ]),
        style: OutlinedButton.styleFrom(
            primary: VotoColors.magenta,
            padding: const EdgeInsets.all(15.0),
            textStyle: Theme.of(context).textTheme.bodyText1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
      );

  Widget timePickerButton(context) => OutlinedButton(
        onPressed: () => _selectTime(context),
        child: Row(children: [
          const Icon(
            Icons.access_time,
            size: 24.0,
          ),
          const SizedBox(width: 10.0),
          Text(selectedTime.toString().replaceAll(RegExp(r'[^\d:]'), ''))
        ]),
        style: OutlinedButton.styleFrom(
            primary: VotoColors.magenta,
            padding: const EdgeInsets.all(15.0),
            textStyle: Theme.of(context).textTheme.bodyText1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0))),
      );

  void _updateCloseDate() {
    pollSettings.closeDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute
    );
  }
  
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2222));
        if (picked != null && picked != selectedDate) {
          selectedDate = picked;
          _updateCloseDate();
          onChanged?.call();
        }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      _updateCloseDate();
      onChanged?.call();
    }
  }

  List<Widget> getList(BuildContext context) {
    return <Widget>[
      const Heading('Closing date'),
      Row(
        children: [
          datePickerButton(context),
          timePickerButton(context)
        ],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
      const Heading('Settings'),
      SimpleCheckbox(
        text: 'Multiple vote',
        color: VotoColors.magenta,
        isChecked: pollSettings.multipleVote,
        onChanged: () {
            pollSettings.multipleVote = !pollSettings.multipleVote;
            onChanged?.call();
          }
      ),
      SimpleCheckbox(
        text: 'Anonymous vote',
        color: VotoColors.magenta,
        isChecked: pollSettings.anonymousVote,
        onChanged: () {
            pollSettings.anonymousVote = !pollSettings.anonymousVote;
            onChanged?.call();
          }
      ),
      Row(children: [
        Expanded(
          child: SimpleCheckbox(
            text: 'Multiple winner',
            color: VotoColors.magenta,
            isChecked: pollSettings.multipleWinner,
            onChanged: () {
                pollSettings.multipleWinner = !pollSettings.multipleWinner;
                onChanged?.call();
              }
          ),
        ),
        pollSettings.multipleWinner
            ? Expanded(
                child: SimpleTextInput(
                  controller: multipleWinnerController,
                  hintText: 'Count',
                  clearable: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onFieldSubmitted: (value) {
                    if (value.isEmpty || int.parse(value) < 2) {
                      multipleWinnerController.text = pollSettings.winnerCount.toString();
                    } else {
                      pollSettings.winnerCount = int.parse(value);
                    }
                  },
                ))
            : Container()
      ]),
      SimpleCheckbox(
        text: 'Allow members to add new option',
        color: VotoColors.magenta,
        isChecked: pollSettings.allowAdd,
        onChanged: () {
            pollSettings.allowAdd = !pollSettings.allowAdd;
            onChanged?.call();
          }
      ),
      pollSettings.allowAdd
          ? SimpleCheckbox(
              text: 'Allow members to vote their own option',
              color: VotoColors.magenta,
              isChecked: pollSettings.allowVoteOwnOption,
              onChanged: () {
                pollSettings.allowVoteOwnOption = !pollSettings.allowVoteOwnOption;
                onChanged?.call();
              }
            )
          : Container(),
      pollSettings.allowAdd
          ? SimpleCheckbox(
              text: 'Show owner of each option',
              color: VotoColors.magenta,
              isChecked: pollSettings.showOptionOwner,
              onChanged: () {
                pollSettings.showOptionOwner = !pollSettings.showOptionOwner;
                onChanged?.call();
              }
            )
          : Container()
    ];
  }
}