import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/poll_settings.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/confirm_button.dart';
import 'package:voto_mobile/widgets/create_item/heading.dart';
import 'package:voto_mobile/widgets/create_item/poll_settings_widgets.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';
import 'package:voto_mobile/widgets/toggle_switch.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class CreateItemPage extends StatefulWidget {
  const CreateItemPage({Key? key}) : super(key: key);

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  bool isPoll = true;
  bool isLuckyDrawer = true;
  bool isSubmitted = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late TextEditingController _multipleWinnerController;
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay selectedTime = const TimeOfDay(hour: 9, minute: 0);
  PollSettings pollSettings = PollSettings();
  late PollSettingsWidgets _pollSettingsWidgetsInstance;

  void toggleType() {
    setState(() {
      isPoll = !isPoll;
    });
  }

  void _handlePollSettingsChange() {
    setState(() {
      selectedDate = _pollSettingsWidgetsInstance.selectedDate;
      selectedTime = _pollSettingsWidgetsInstance.selectedTime;
      pollSettings = _pollSettingsWidgetsInstance.pollSettings;
    });
  }

  Future<bool> _handlePop() {
    /***
     * If user hasnt given any input, we can safely pop
     */
    if(_titleController.text.isEmpty && _descriptionController.text.isEmpty) {
      return Future.value(true);
    }
    final willPop = showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Discard',
          style: Theme.of(context).textTheme.headline2,
        ),
        content: Text(
          'This item will be deleted',
          style: Theme.of(context).textTheme.bodyText1
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Discard'),
            style: TextButton.styleFrom(
              primary: VotoColors.danger
            )
          ),
        ],
      ),
    ).then((value) async {
      String? teamId =
          Provider.of<PersistentState>(context, listen: false).currentTeam?.id;
      String? itemId =
          Provider.of<PersistentState>(context, listen: false).currentItem?.id;
      if(value ?? true && itemId != null && teamId != null) {
        await FirebaseDatabase.instance.ref('items/$itemId').remove();
        await FirebaseDatabase.instance.ref('options/$itemId').remove();
        await FirebaseDatabase.instance.ref('teams/$teamId/items/$itemId').remove();
        Provider.of<PersistentState>(context, listen: false).disposeItem();
      }
      return value ?? true;
    });
    return willPop;
  }

  Future<void> _createItem() async {
    String? teamId = Provider.of<PersistentState>(context, listen: false).currentTeam?.id;
    String? itemId = Provider.of<PersistentState>(context, listen: false).currentItem?.id;
    DatabaseReference itemRef;
    if(itemId == null) {
      itemRef = FirebaseDatabase.instance.ref('items/').push();
    } else {
      itemRef = FirebaseDatabase.instance.ref('items/$itemId');
    }
    final modified = DateTime.now();
    Items item = Items(
      id: itemId ?? itemRef.key,
      title: _titleController.text,
      description: _descriptionController.text,
      type: isPoll ? 'poll' : 'random',
      lastModified: modified,
      pollSettings: pollSettings,
      randomType: isPoll ? null : (isLuckyDrawer ? 'lucky' : 'pair')
    );
    if(itemRef.key != null) {
      await itemRef.set(item.toJson());
      await FirebaseDatabase.instance.ref('teams/$teamId/items').update({
        '${itemRef.key}': modified.toIso8601String()
      });
    }
    Provider.of<PersistentState>(context, listen: false).updateItem(item);
  }

  @override
  void initState() {
    super.initState();
    _multipleWinnerController =
        TextEditingController(text: pollSettings.winnerCount.toString());
    pollSettings.closeDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute
    );
    _pollSettingsWidgetsInstance = PollSettingsWidgets(
        selectedDate: selectedDate,
        selectedTime: selectedTime,
        pollSettings: pollSettings,
        multipleWinnerController: _multipleWinnerController,
        onChanged: _handlePollSettingsChange);
  }

  @override
  void dispose() {
    _multipleWinnerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pollSettingsWidgets = _pollSettingsWidgetsInstance.getList(context);

    List<Widget> _randomSettingsWidgets = <Widget>[
      const Heading('Settings'),
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
            /***
             * Help text that describes the random type chosen
             */
            Row(
              children: [
                const Icon(Icons.info, color: Color(0xffaaaaaa)),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                      isLuckyDrawer
                          ? 'Lucky drawer randomly picks one out of the options'
                          : 'Pair generator randomly pairs team members with the options',
                      textAlign: TextAlign.left,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: const Color(0xffaaaaaa))),
                )
              ],
            )
          ],
        ),
      ),
    ];

    List<Widget> _list = <Widget>[
      const Heading('Title'),
      SimpleTextInput(
        max: 30,
        controller: _titleController,
        onChanged: (value) {
          setState(() {});
        },
      ),
      const Heading('Description'),
      SimpleTextInput(
          max: 300,
          controller: _descriptionController,
          onChanged: (value) {
            setState(() {});
          },
          multiline: true),
      const Heading('Type'),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ToggleSwitch(
          left: isPoll,
          textLeft: 'Poll',
          textRight: 'Random',
          onChanged: toggleType,
        ),
      ),
      if (isPoll) ..._pollSettingsWidgets else ..._randomSettingsWidgets,
      const SizedBox(height: 30.0),
    ];

    return Consumer<PersistentState>(builder: (context, appState, child) => 
      VotoScaffold(
        useMenu: false,
        title: 'Create new item',
        titleContext: appState.currentTeam?.name,
        onWillPop: _handlePop,
        body: Column(children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 42.5, right: 42.5),
            child: ListView.separated(
                itemBuilder: (context, index) => _list[index],
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10.0),
                itemCount: _list.length),
          )),
          ConfirmButton(
            confirmText: 'Next',
            disabled: _titleController.text.isEmpty ||
                _descriptionController.text.isEmpty,
            isLoading: isSubmitted,
            onConfirm: () {
              setState(() => isSubmitted = true);
              _createItem().then((_) {
                setState(() => isSubmitted = false);
                Navigator.pushNamed(context, '/add_option_page');
              });
            },
            onCancel: () {
              _handlePop().then((willPop) {
                if (willPop) Navigator.of(context).pop();
              });
            },
            height: 75.0,
          )
      ]))
    );
  }
}