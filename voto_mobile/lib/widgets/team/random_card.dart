import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/team/card_action_button.dart';

class RandomCard extends StatelessWidget {
  final Items item;
  final bool showStartRandom;
  final Function()? onBuildCompleted;
  const RandomCard({
    Key? key,
    required this.item,
    this.showStartRandom = true,
    this.onBuildCompleted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => onBuildCompleted?.call());
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
        padding: const EdgeInsets.all(30.0),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 5.0,
                  offset: Offset(1.0, 2.0))
            ],
            gradient: LinearGradient(
                begin: Alignment(-1.0, 0.0),
                end: Alignment(1.0, 0.0),
                colors: [
                  VotoColors.flamingo,
                  VotoColors.magenta,
                  Color.fromARGB(255, 123, 181, 224)
                ],
                stops: [0, 0.5742, 1],
                transform: GradientRotation(1.0667452))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  '${item.title}',
                  style: GoogleFonts.inter(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: VotoColors.white),
                )),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              '${item.description}',
              style: GoogleFonts.inter(fontSize: 12.0, color: VotoColors.white),
            ),
            const SizedBox(height: 20.0),
            CardActionButton(
              text: 'Add option',
              onPressed: () {
                Provider.of<PersistentState>(context, listen: false).updateItem(item);
                Provider.of<PersistentState>(context, listen: false).isCreatingItem = false;
                Navigator.of(context).pushNamed('/add_option_page');
              },
              isPrimary: false,
            ),
            const SizedBox(height: 10),
            CardActionButton(
              text: showStartRandom ? 'Start random' : 'View random',
              onPressed: () {
                Provider.of<PersistentState>(context, listen: false)
                    .updateItem(item);
                Navigator.of(context).pushNamed('/random_page');
              },
            )
          ],
        ));
  }
}
