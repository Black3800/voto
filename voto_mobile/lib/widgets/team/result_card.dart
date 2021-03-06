import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/team/card_action_button.dart';

class ResultCard extends StatelessWidget {
  final Items item;
  final Function()? onBuildCompleted;
  const ResultCard({
    Key? key,
    required this.item,
    this.onBuildCompleted
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        ?.addPostFrameCallback((_) => onBuildCompleted?.call());
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 10.0),
      padding: const EdgeInsets.all(30.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: VotoColors.indigo,
          style: BorderStyle.solid,
          width: 0.5
        ),
        borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        boxShadow: const <BoxShadow>[BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 5.0,
          offset: Offset(1.0, 2.0)
        )],
        color: VotoColors.white
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
                        color: VotoColors.indigo
                        ),
                    ),
                    Text(
                      item.type == 'poll' && item.pollSettings?.closeDate != null
                            ? 'Closed on ${item.pollSettings?.closeDateFormatted}'
                            : 'Closed',
                      style: GoogleFonts.inter(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w300,
                        color: VotoColors.indigo),
                    ),
                  ],),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Text(
              '${item.description}',
              style: GoogleFonts.inter(fontSize: 12.0, color: VotoColors.indigo),
            ),
          const SizedBox(height: 20.0),
          CardActionButton(text: 'View full result', onPressed: () {
            Provider.of<PersistentState>(context, listen: false).updateItem(item);
            if (item.type == 'poll') {
              Navigator.of(context).pushNamed('/poll_result_page');
            } else {
              Navigator.of(context).pushNamed('/random_page');
            }
          },)
        ],
      )
    );
  }
}