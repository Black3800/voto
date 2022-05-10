import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/team/card_action_button.dart';

class PollCard extends StatelessWidget {
  final Items item;
  const PollCard({ Key? key, required this.item }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 10.0),
      padding: const EdgeInsets.all(30.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        boxShadow: <BoxShadow>[BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 5.0,
          offset: Offset(1.0, 2.0)
        )],
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [VotoColors.magenta, VotoColors.indigo, Color.fromARGB(255, 78, 175, 255)],
          stops: [0, 0.4375, 1],
          transform: GradientRotation(0.95713856)
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.title}',
                      style: GoogleFonts.inter(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                        color: VotoColors.white
                        ),
                    ),
                    Text(
                      'Closing on ${item.pollSettings?.closeDateFormatted}',
                      style: GoogleFonts.inter(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w300,
                        color: VotoColors.white
                        ),
                      )
                  ],),
              ),
              IconButton(
                padding: const EdgeInsets.only(left: 10.0),
                icon: const Icon(Icons.share, color: VotoColors.white,),
                iconSize: 24.0,
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Text(
              '${item.description}',
              style: GoogleFonts.inter(fontSize: 12.0, color: VotoColors.white),
            ),
          const SizedBox(height: 20.0),
          CardActionButton(
            text: 'Vote now',
            isPrimary: false,
            onPressed: () {
              Provider.of<PersistentState>(context, listen: false).updateItem(item);
              Navigator.pushNamed(context, '/poll_page');
            },
          )
        ],
      )
    );
  }
}