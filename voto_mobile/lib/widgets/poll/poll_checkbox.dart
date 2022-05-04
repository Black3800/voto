import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class Poll_check extends StatefulWidget {
  final String name;
  const Poll_check({Key? key, required this.name}) : super(key: key);

  @override
  State<Poll_check> createState() => _Poll_checkState();
}

class _Poll_checkState extends State<Poll_check> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(
            width: 1,
            color: Color(0xFFF2F4F8),
          ),
          bottom: BorderSide(
            width: 1,
            color: Color(0xFFF2F4F8),
          ),
        ),
      ),
      child: Theme(
        data: ThemeData(
          checkboxTheme: CheckboxThemeData(
            side: BorderSide(width: 1, color: VotoColors.indigo),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        child: CheckboxListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 10),
            child:
                Text(widget.name, style: Theme.of(context).textTheme.bodyText1),
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: isChecked,
          onChanged: (value) {
            setState(() => isChecked = value!);
          },
          activeColor: VotoColors.indigo,
          contentPadding: EdgeInsets.symmetric(horizontal: 0),
        ),
      ),
    );
  }
}


// Container(
//         child: Theme(
//       data:
//           Theme.of(context).copyWith(unselectedWidgetColor: VotoColors.indigo),
//       child: CheckboxListTile(
//         title: Text(widget.name, style: Theme.of(context).textTheme.bodyText1),
//         controlAffinity: ListTileControlAffinity.leading,
//         value: isChecked,
//         onChanged: (value) {
//           setState(() => isChecked = value!);
//         },
//         activeColor: VotoColors.indigo,
//       ),
//     ));