import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/widgets/manageteam/passcodefiled.dart';

class Pass extends StatefulWidget {
  bool isEditing;
  Function(String)? onChanged;
  String? value;
  Pass({
    required this.isEditing,
    this.onChanged,
    this.value = '    ',
    Key? key
  }) : super(key: key);

  @override
  State<Pass> createState() => _PassState();
}

class _PassState extends State<Pass> {
  final TextEditingController _newPasscodeController = TextEditingController();

  Future<void> _changePasscode() async {
    String? newPasscode = await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('New passcode'),
        content: IntrinsicHeight(
          child: Column(
            children: [
              const Text('Leave blank to remove passcode'),
              TextFormField(
                controller: _newPasscodeController,
                maxLength: 4,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: const InputDecoration(
                  hintText: '4 digit number'
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, _newPasscodeController.text),
            child: const Text('Save'),
          ),
        ],
      )
    );
    if(newPasscode != null && newPasscode != widget.value) {
      WidgetsBinding.instance?.addPostFrameCallback((_) => setState(() {
        if(newPasscode.isEmpty) {
          widget.onChanged?.call('');
        } else if(newPasscode.length == 4) {
          widget.onChanged?.call(newPasscode);
        }
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PersistentState>(builder: (context, appState, child) =>
            InkWell(
              onTap: appState.currentUser!.uid == appState.currentTeam?.owner
                  ? _changePasscode
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    4,
                    (index) =>
                        Passcode(passNumber: widget.value?[index] ?? '')),
              ),
            )
    );
  }
}
