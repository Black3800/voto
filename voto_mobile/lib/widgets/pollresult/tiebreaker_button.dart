import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/choice.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/poll_settings.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/rich_button.dart';

class TiebreakerButton extends StatelessWidget {
  final List<Choice> winners;
  const TiebreakerButton({ Key? key, required this.winners }) : super(key: key);

  Future<Items> _createTiebreaker(BuildContext context) async {
    final currentItem = Provider.of<PersistentState>(context, listen: false).currentItem!;
    final String? teamId =
        Provider.of<PersistentState>(context, listen: false).currentTeam?.id;
    DatabaseReference itemRef = FirebaseDatabase.instance.ref('items/').push();
    final modified = DateTime.now();
    final pollSettings = PollSettings.fromJson(currentItem.pollSettings!.toJson());
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    const nineAm = TimeOfDay(hour: 9, minute: 0);
    pollSettings.closeDate = DateTime(
      tomorrow.year,
      tomorrow.month,
      tomorrow.day,
      nineAm.hour,
      nineAm.minute
    );
    Items item = Items(
        id: itemRef.key,
        title: '(Tiebreaker) ${currentItem.title}',
        description: 'Tiebreaker of the previous poll',
        type: 'poll',
        lastModified: modified,
        pollSettings: pollSettings);
    if (itemRef.key != null) {
      await itemRef.set(item.toJson());
      await FirebaseDatabase.instance
          .ref('teams/$teamId/items')
          .update({'${itemRef.key}': modified.toIso8601String()});
      Map _options = winners.asMap().map((key, value) =>
          MapEntry(value.id, {'text': value.text, 'vote_count': 0}));
      await FirebaseDatabase.instance
          .ref('options/${item.id}/choices')
          .set(_options);
    }
    return item;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(10.0),
          child: RichButton(
              text: 'Create tiebreaker',
              icon: Icons.equalizer_rounded,
              accentColor: VotoColors.magenta,
              onPressed: () async {
                final _item = await _createTiebreaker(context);
                Provider.of<PersistentState>(context, listen: false).updateItem(_item);
                Navigator.of(context).popAndPushNamed('/create_item_page');
              },
              width: 250));
  }
}