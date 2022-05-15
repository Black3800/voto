import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/poll/poll_item_container.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';

class PollBody extends StatefulWidget {
  final bool isMultipleValue;
  final bool isEditable;
  final bool isSelectable;
  final bool isAddable;
  final bool isLoading;
  final Function(String?, {bool isInitialValue})? onRadioChanged;
  final Function({required String id, required bool value})? onCheckboxChanged;
  const PollBody({
    Key? key,
    this.isMultipleValue = false,
    this.isEditable = true,
    this.isSelectable = true,
    this.isAddable = false,
    this.isLoading = false,
    this.onRadioChanged,
    this.onCheckboxChanged
  }) : super(key: key);

  @override
  State<PollBody> createState() => _PollBodyState();
}

class _PollBodyState extends State<PollBody> {
  bool isEditing = false;
  String? itemId;
  String? uid;
  late DatabaseReference optionsRef;
  final TextEditingController _addOptionController = TextEditingController();

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
      _addOption(newOption);
    }
    _addOptionController.clear();
  }

  Future<void> _addOption(String _newOption) async {
    if (_newOption.isEmpty) return;
    String? itemId =
        Provider.of<PersistentState>(context, listen: false).currentItem!.id;
    bool showOptionOwner =
        Provider.of<PersistentState>(context, listen: false).currentItem!.pollSettings!.showOptionOwner;
    bool isPoll =
        Provider.of<PersistentState>(context, listen: false).currentItem!.type == 'poll';
    String? uid =
        Provider.of<PersistentState>(context, listen: false).currentUser!.uid;
    if (itemId != null) {
      DatabaseReference choiceRef =
          FirebaseDatabase.instance.ref('options/$itemId/choices').push();
      await choiceRef
          .set({
            'text': _newOption,
            'owner': showOptionOwner ? uid : null,
            'vote_count': isPoll ? 0 : null
          });
    }
  }

  Future<void> _handleDelete(String? choiceId) async {
    if(itemId != null && choiceId != null) {
      await FirebaseDatabase.instance.ref('options/$itemId/choices/$choiceId').remove();
    }
  }

  @override
  void initState() {
    super.initState();
    itemId = Provider.of<PersistentState>(context, listen: false).currentItem!.id;
    uid = Provider.of<PersistentState>(context, listen: false).currentUser!.uid;
    optionsRef = FirebaseDatabase.instance.ref('options/$itemId/choices');
  }

  @override
  void dispose() {
    _addOptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: optionsRef.onValue,
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator()
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
          final data = snapshot.data?.snapshot.value as Map<dynamic,dynamic>?;
          List<Choice> choices = [];
          if (data != null) {
            for (final choiceData in data.entries) {
              final choice = Choice.fromJson(choiceData.value);
              choice.id = choiceData.key;
              choices.add(choice);
            }
          }
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              PollItemContainer(
                choices: choices,
                isEditable: widget.isEditable,
                isSelectable: widget.isSelectable,
                isMultipleValue: widget.isMultipleValue,
                onRadioChanged: widget.onRadioChanged,
                onCheckboxChanged: widget.onCheckboxChanged,
                onDeleted: _handleDelete,
              ),
              widget.isAddable ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: addOptionButton(),
              ) : Container()
            ]);
        }
        return Container();
      }
    );
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
}
