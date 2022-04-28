import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class Purple_button extends StatelessWidget {
  String title;
  double width;
  Purple_button(this.title, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        width: width,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(20)),
          color: VotoColors.indigo,
          boxShadow: [
            //background color of box
            BoxShadow(
              color: Color(0xff000000).withOpacity(0.20),

              blurRadius: 4, // soften the shadow
              //extend the shadow
              offset: Offset(
                2, // Move to right 10  horizontally
                1, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ));
  }
}
