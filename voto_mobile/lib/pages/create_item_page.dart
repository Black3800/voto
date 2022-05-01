import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/confirm_button.dart';
import 'package:voto_mobile/widgets/create_item/simple_checkbox.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';
import 'package:voto_mobile/widgets/toggle_switch.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';
import 'package:intl/intl.dart';

class CreateItemPage extends StatefulWidget {
  const CreateItemPage({ Key? key }) : super(key: key);

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  bool isPoll = true;
  bool isLuckyDrawer = true;
  int numberOfWinners = 2;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late TextEditingController _multipleWinnerController;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay selectedTime = const TimeOfDay(hour: 9, minute: 0);
  PollSettings pollSettings = PollSettings();

  void toggleType() {
    setState(() {
      isPoll = !isPoll;
    });
  }

  @override
  void initState() {
    super.initState();
    _multipleWinnerController = TextEditingController(text: numberOfWinners.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _multipleWinnerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2222));
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
    }

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (picked != null && picked != selectedTime) {
        setState(() {
          selectedTime = picked;
        });
      }
    }
    
    Widget heading(text) => Text(
      text,
      style: Theme.of(context).textTheme.headline3!.merge(const TextStyle(color: VotoColors.black))
    );

    Widget datePickerButton() =>  OutlinedButton(
                                    onPressed: () => _selectDate(context),
                                    child: Row(children: [
                                      const Icon(Icons.event, size: 24.0,),
                                      const SizedBox(width: 10.0),
                                      Text(DateFormat('yMMMMd').format(selectedDate))
                                    ]),
                                    style: OutlinedButton.styleFrom(
                                      primary: VotoColors.magenta,
                                      padding: const EdgeInsets.all(15.0),
                                      textStyle: Theme.of(context).textTheme.bodyText1,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                                    ),
                                  );

    Widget timePickerButton() =>  OutlinedButton(
                                    onPressed: () => _selectTime(context),
                                    child: Row(children: [
                                      const Icon(Icons.access_time, size: 24.0,),
                                      const SizedBox(width: 10.0),
                                      Text(selectedTime.toString().replaceAll(RegExp(r'[^\d:]'), ''))
                                    ]),
                                    style: OutlinedButton.styleFrom(
                                      primary: VotoColors.magenta,
                                      padding: const EdgeInsets.all(15.0),
                                      textStyle: Theme.of(context).textTheme.bodyText1,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
                                    ),
                                  );

    List<Widget> _pollSettingsWidgets = <Widget>[
      heading('Closing date'),
      Row(
        children: [datePickerButton(), timePickerButton()],
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
      heading('Settings'),
      SimpleCheckbox(
        text: 'Multiple vote',
        color: VotoColors.magenta,
        isChecked: pollSettings.multipleVote,
        onChanged: () {
          setState(() {
            pollSettings.multipleVote =
                !pollSettings.multipleVote;
          });
        },
      ),
      SimpleCheckbox(
        text: 'Anonymous vote',
        color: VotoColors.magenta,
        isChecked: pollSettings.anonymousVote,
        onChanged: () {
          setState(() {
            pollSettings.anonymousVote = !pollSettings.anonymousVote;
          });
        },
      ),
      SimpleCheckbox(
        text: 'Tiebreaker',
        color: VotoColors.magenta,
        isChecked: pollSettings.tiebreaker,
        onChanged: () {
          setState(() {
            pollSettings.tiebreaker = !pollSettings.tiebreaker;
          });
        },
      ),
      Row(
        children: [
          Expanded(
            child: SimpleCheckbox(
              text: 'Multiple winner',
              color: VotoColors.magenta,
              isChecked: pollSettings.multipleWinner,
              onChanged: () {
                setState(() {
                  pollSettings.multipleWinner = !pollSettings.multipleWinner;
                });
              },
            ),
          ),
          pollSettings.multipleWinner
            ? Expanded(
                child: SimpleTextInput(
                  controller: _multipleWinnerController,
                  hintText: 'Count',
                  clearable: false,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onFieldSubmitted: (value) {
                    if(value.isEmpty || int.parse(value) < 2) {
                      _multipleWinnerController.text = numberOfWinners.toString();
                    } else {
                      numberOfWinners = int.parse(value);
                    }
                  },
              ))
            : Container()
        ]
      ),
      SimpleCheckbox(
        text: 'Allow members to add new option',
        color: VotoColors.magenta,
        isChecked: pollSettings.allowAdd,
        onChanged: () {
          setState(() {
            pollSettings.allowAdd = !pollSettings.allowAdd;
          });
        },
      ),
      pollSettings.allowAdd
          ? SimpleCheckbox(
              text: 'Allow members to vote their own option',
              color: VotoColors.magenta,
              isChecked: pollSettings.allowVoteOwnOption,
              onChanged: () {
                setState(() {
                  pollSettings.allowVoteOwnOption = !pollSettings.allowVoteOwnOption;
                });
              },
            )
          : Container(),
      pollSettings.allowAdd
          ? SimpleCheckbox(
              text: 'Show owner of each option',
              color: VotoColors.magenta,
              isChecked: pollSettings.showOptionOwner,
              onChanged: () {
                setState(() {
                  pollSettings.showOptionOwner = !pollSettings.showOptionOwner;
                });
              },
            )
          : Container()
    ];

    List<Widget> _randomSettingsWidgets = <Widget>[
      heading('Settings'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            ToggleSwitch(
              left: isLuckyDrawer,
              textLeft: 'Lucky drawer',
              textRight: 'Pair generator',
              onChanged: () {
                setState(() {
                  isLuckyDrawer = !isLuckyDrawer;
                });
              },
            ),
            const SizedBox(height: 10.0),
            Row(children: [
              const Icon(Icons.info, color: Color(0xffaaaaaa)),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  isLuckyDrawer
                          ? 'Lucky drawer randomly picks one out of the options'
                          : 'Pair generator randomly pairs team members with the options',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText1?.apply(color: const Color(0xffaaaaaa))
                ),
              )
            ],)
          ],
        ),
      ),
    ];

    List<Widget> _list = <Widget>[
      heading('Title'),
      SimpleTextInput(
        controller: _titleController,
        onChanged: (value) {
          setState(() {});
        },
      ),
      heading('Description'),
      SimpleTextInput(
        controller: _descriptionController,
        onChanged: (value) {
          setState(() {});
        },
        multiline: true
      ),
      heading('Type'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ToggleSwitch(
          left: isPoll,
          textLeft: 'Poll',
          textRight: 'Random',
          onChanged: toggleType,
        ),
      ),
      if(isPoll)
        ..._pollSettingsWidgets
      else
        ..._randomSettingsWidgets,
      const SizedBox(height: 30.0),
    ];

    return VotoScaffold(
        useMenu: false,
        title: 'Create new item', 
        titleContext: 'Integrated Project II',
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 42.5,
                  right: 42.5
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) => _list[index],
                  separatorBuilder: (context, index) => const SizedBox(height: 10.0),
                  itemCount: _list.length),
              )
            ),
            ConfirmButton(
              confirmText: 'Next',
              disabled: _titleController.text.isEmpty || _descriptionController.text.isEmpty,
              onConfirm: () {
                Navigator.pushNamed(context, '/add_option_page');
              },
              onCancel: () {
                Navigator.pop(context);
              },
              height: 75.0,
            )
          ]
        )
    );
  }
}

class PollSettings {
  bool multipleVote;
  bool anonymousVote;
  bool tiebreaker;
  bool multipleWinner;
  bool allowAdd;
  bool allowVoteOwnOption;
  bool showOptionOwner;

  PollSettings({
    this.multipleVote = false,
    this.anonymousVote = false,
    this.tiebreaker = false,
    this.multipleWinner = false,
    this.allowAdd = false,
    this.allowVoteOwnOption = false,
    this.showOptionOwner = false
  });
}