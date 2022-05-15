import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/addoption/add_option_item.dart';
import 'package:voto_mobile/widgets/poll/poll_checkbox.dart';
import 'package:voto_mobile/widgets/poll/poll_radio.dart';

class PollItemContainer extends StatefulWidget {
  final List<Choice> choices;
  final bool isEditable;
  final bool isSelectable;
  final bool isMultipleValue;
  final Function(String?, {bool isInitialValue, String? deletedId})? onRadioChanged;
  final Function({required String id, required bool? value})? onCheckboxChanged;
  final Function(String?)? onDeleted;
  const PollItemContainer({
    Key? key,
    required this.choices,
    this.isEditable = false,
    this.isSelectable = true,
    this.isMultipleValue = false,
    this.onRadioChanged,
    this.onCheckboxChanged,
    this.onDeleted
  }) : super(key: key);

  @override
  State<PollItemContainer> createState() => _PollItemContainerState();
}

class _PollItemContainerState extends State<PollItemContainer> {
  bool isEditing = false;
  String? _radioValue;
  String? uid;
  Map<String, bool> _checkbox = <String, bool>{};

  void _handleDelete(String id) {
    if (widget.isSelectable) {
      if (widget.isMultipleValue) {
        _checkbox.remove(id);
        widget.onCheckboxChanged?.call(id: id, value: null);
      } else {
        widget.onRadioChanged?.call(null, deletedId: id);
      }
    }
    widget.onDeleted?.call(id);
  }

  @override
  void initState() {
    super.initState();
    uid = Provider.of<PersistentState>(context, listen: false).currentUser!.uid;
    if (widget.isMultipleValue) {
      for (final choice in widget.choices) {
        bool _isChecked = choice.votedBy?[uid] != null;
        _checkbox['${choice.id}'] = _isChecked;
        widget.onCheckboxChanged?.call(
          id: '${choice.id}',
          value: _isChecked
        );
      }
    } else {
      // print(widget.choices.to)
      Choice initial = widget.choices.firstWhere((element) => element.votedBy?[uid] != null, orElse: () => Choice());
      if (initial.id != null) {
        // If exists
        _radioValue = initial.id;
        widget.onRadioChanged?.call(_radioValue, isInitialValue: true);
      }
    }
  }

  @override
  void didUpdateWidget(covariant PollItemContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMultipleValue) {
      for (final choice in widget.choices) {
        if (!_checkbox.containsKey(choice.id)) {
          bool _isChecked = choice.votedBy?[uid] != null;
          _checkbox['${choice.id}'] = _isChecked;
          widget.onCheckboxChanged?.call(id: '${choice.id}', value: _isChecked);
        } else {
          widget.onCheckboxChanged?.call(id: '${choice.id}', value: _checkbox[choice.id] ?? false);
        }
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    if (widget.choices.isEmpty) {
      return Container(
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
      );
    }
    return Column(
      children: [
        if (widget.isEditable) Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            editOptionButton(),
          ],
        ),
        ...widget.choices.map((e) => pollItem(e))
      ],
    );
  }

  Widget pollItem(Choice choice) {
    if(!widget.isSelectable || isEditing) {
      return AddOptionItem(
        text: '${choice.text}',
        isEditing: isEditing,
        onDeleted: () => _handleDelete(choice.id!),
      );
    }
    if (widget.isMultipleValue) {
      return PollCheckbox(
        text: '${choice.text}',
        isChecked: _checkbox[choice.id] ?? false,
        isEditing: isEditing,
        onChanged: (value) {
          _checkbox.update('${choice.id}', (_value) => !_value);
          setState(() => _checkbox = Map.from(_checkbox));
          widget.onCheckboxChanged?.call(
            id: '${choice.id}',
            value: value ?? false
          );
        },
        onDeleted: () => _handleDelete(choice.id!),
      );
    } else {
      return PollRadio(
        text: '${choice.text}',
        value: '${choice.id}',
        groupValue: _radioValue,
        onChanged: (String? value) {
          setState(() => _radioValue = value);
          widget.onRadioChanged?.call(value);
        },
        onDeleted: () => _handleDelete(choice.id!),
        isEditing: isEditing,
      );
    }
  }

  Widget editOptionButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isEditing = !isEditing;
        });
      },
      child: Text(
              isEditing ? 'Done' : 'Edit',
              style: GoogleFonts.inter(
                color: VotoColors.indigo,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}