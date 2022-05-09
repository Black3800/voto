import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/addoption/add_option_item.dart';
import 'package:voto_mobile/widgets/poll/poll_checkbox.dart';
import 'package:voto_mobile/widgets/poll/poll_radio.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';

class PollBody extends StatefulWidget {
  final bool isMultipleValue;
  final bool isEditable;
  final bool isSelectable;
  final bool isAddable;
  final Function(String)? onAdded;
  const PollBody({
    Key? key,
    this.isMultipleValue = false,
    this.isEditable = true,
    this.isSelectable = true,
    this.isAddable = false,
    this.onAdded
  }) : super(key: key);

  @override
  State<PollBody> createState() => _PollBodyState();
}

class _PollBodyState extends State<PollBody> {
  bool isEditing = false;
  String _radioValue = '';
  String? itemId;
  late Future<List<Choice>> _choices;
  final TextEditingController _addOptionController = TextEditingController();
  bool listenerAdded = false;

  void _handleRadioChange(value) {
    setState(() => _radioValue = value);
  }

  List<Choice> _applyChoices(DataSnapshot snapshot) {
    if (snapshot.exists) {
      final data = snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        List<Choice> _newChoices = [];
        for (String choiceId in data.keys) {
          Choice choice =
              Choice.fromJson(data[choiceId] as Map<dynamic, dynamic>);
          choice.id = choiceId;
          _newChoices.add(choice);
        }
        return _newChoices;
      }
    }
    return [];
  }

  Future<List<Choice>> _getChoices() async {
    if(itemId != null) {
      DatabaseReference optionsRef = FirebaseDatabase.instance.ref('options/$itemId/choices');
      final snapshot = await optionsRef.get();
      if (!listenerAdded) {
        optionsRef.onValue.listen((event) {
          if(event.snapshot.exists) {
            _choices = Future.value(_applyChoices(event.snapshot));
            WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {}));
          }
        });
        optionsRef.onChildRemoved.listen((event) async {
          final currentChoices = await _choices;
          if(currentChoices.length == 1) {
            _choices = Future.value([]);
            WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {}));
          }
        });
        listenerAdded = true;
      }
      return _applyChoices(snapshot);
    }
    return [];
  }

  Future<void> _showAddOptionDialog() async {
    String? newOption = await showDialog<String?>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Add new option',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: SimpleTextInput(
          controller: _addOptionController,
          max: 100,
          multiline: true,
          autofocus: true,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text('Cancel', style: GoogleFonts.inter(
              fontWeight: FontWeight.normal
            )),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _addOptionController.text),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if(states.contains(MaterialState.disabled)) {
                  return VotoColors.indigo.shade300;
                } else if(states.contains(MaterialState.pressed)) {
                  return VotoColors.indigo.shade700;
                }
                return VotoColors.indigo;
              }),
              fixedSize: MaterialStateProperty.all<Size>(const Size.fromWidth(100))
            )
            child: Text('Add', style: GoogleFonts.inter(
              color: VotoColors.white
            )),
          ),
        ],
      ),
    );
    if(newOption != null) {
      widget.onAdded?.call(newOption);
    }
    _addOptionController.clear();
  }

  Future<void> _handleDelete(String? choiceId) async {
    if(itemId != null && choiceId != null) {
      await FirebaseDatabase.instance.ref('options/$itemId/choices/$choiceId').remove();
    }
  }

  @override
  void initState() {
    super.initState();
    itemId = Provider.of<PersistentState>(context, listen: false).currentItem?.id;
    _choices = _getChoices();
  }
  @override
  void dispose() {
    _addOptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _choices,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final _pollItems = snapshot.data as List<Choice>?;
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              widget.isEditable && _pollItems!.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        editOptionButton(),
                      ],
                    )
                  : Container(),
              if (_pollItems!.isNotEmpty)
                    ...List<Widget>.generate(_pollItems.length,
                        (index) => pollItem(_pollItems[index]))
                  else
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: VotoColors.gray,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Empty',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: VotoColors.black.shade300
                            )
                          ),
                          Text('Add some options',
                            style: GoogleFonts.inter(
                              color: VotoColors.black.shade300
                            )
                          )
                        ]),
                    ),
              widget.isAddable ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: addOptionButton(),
              ) : Container()
            ]);
        } else {
          return const Center(
            child: SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator()
            ),
          );
        }

      }
    );
  }

  Widget pollItem(Choice choice) {
    if(!widget.isSelectable) {
      return AddOptionItem(
        text: '${choice.text}',
        isEditing: isEditing,
        onDelete: () => _handleDelete(choice.id),
      );
    }
    if (widget.isMultipleValue) {
      return Poll_check(
        name: '${choice.text}',
        isEditing: isEditing,
      );
    } else {
      return PollRadio(
        text: '${choice.text}',
        value: '${choice.id}',
        groupValue: _radioValue,
        onChanged: _handleRadioChange,
        isEditing: isEditing,
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
      onPressed: _showAddOptionDialog,
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
      onPressed: () {
        setState(() {
          isEditing = !isEditing;
        });
      },
      child: isEditing
          ? Text(
              'Done',
              style: GoogleFonts.inter(
                color: VotoColors.indigo,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            )
          : Text(
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
