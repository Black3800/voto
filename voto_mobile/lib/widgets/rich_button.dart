import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class RichButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final MaterialColor accentColor;
  final Function()? onPressed;
  final double? width;
  const RichButton({ Key? key, required this.text, required this.icon, required this.accentColor, required this.onPressed, this.width }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 4.0,
            offset: Offset(1.0, 2.0)
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(20.0))
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Icon(icon, color: VotoColors.white),
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4.0),
              ),
              width != null ? Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, bottom: 0.0, left: 20.0, right: 10.0),
                    child: Text(text, textAlign: TextAlign.center,)),
              ) : Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, bottom: 0.0, left: 20.0, right: 10.0),
                      child: Text(text, textAlign: TextAlign.center,))
            ],
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.pressed)) {
              return VotoColors.white[600];
            }
            return VotoColors.white;
          }),
          foregroundColor: MaterialStateProperty.all<Color>(accentColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
          )),
          elevation: MaterialStateProperty.all<double>(0.0)
        ),
      ),
    );
  }
}