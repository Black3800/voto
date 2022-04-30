import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class WideButton extends StatelessWidget {
  final String text;
  final MaterialColor foregroundColor;
  final MaterialColor backgroundColor;
  final bool isElevated;
  final Function()? onPressed;
  const WideButton({ Key? key, required this.text, this.foregroundColor = VotoColors.white, this.backgroundColor = VotoColors.indigo, this.isElevated = true, required this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: isElevated ? const <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 4.0,
            offset: Offset(2.0, 1.0)
          )
        ] : null,
        borderRadius: const BorderRadius.all(Radius.circular(20.0))
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
            left: 0.0,
            right: 0.0
          ),
          child: Text(text, style: Theme.of(context).textTheme.button?.merge(TextStyle(color: foregroundColor)))),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if(states.contains(MaterialState.pressed)) {
                return backgroundColor[600];
              }
              return backgroundColor;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
            )),
            elevation: MaterialStateProperty.all<double>(0.0),
            minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(35.0))
          ),
      ),
    );
  }
}