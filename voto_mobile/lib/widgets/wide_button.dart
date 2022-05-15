import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';

class WideButton extends StatelessWidget {
  final String text;
  final MaterialColor foregroundColor;
  final MaterialColor backgroundColor;
  final bool disabled;
  final bool isElevated;
  final bool isBold;
  final bool isLoading;
  final Function()? onPressed;
  const WideButton({
    Key? key,
    required this.text,
    this.foregroundColor = VotoColors.white,
    this.backgroundColor = VotoColors.indigo,
    this.disabled = false,
    this.isElevated = true,
    this.isBold = true,
    this.isLoading = false,
    required this.onPressed
  }) : super(key: key);

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
        onPressed: !(disabled || isLoading) ? onPressed : null,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
            bottom: 10.0,
            left: 0.0,
            right: 0.0
          ),
          child: isLoading
                ? const SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 0.75,
                    ),
                  )
                : Text(text,
                    style: Theme.of(context).textTheme.button?.merge(
                        GoogleFonts.inter(
                            color: foregroundColor,
                            fontWeight: isBold ? null : FontWeight.normal)))
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.pressed)) {
              return backgroundColor[600];
            } else if(states.contains(MaterialState.disabled)) {
              return backgroundColor[300];
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