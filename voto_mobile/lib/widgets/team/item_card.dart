import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/items.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/widgets/team/poll_card.dart';
import 'package:voto_mobile/widgets/team/random_card.dart';
import 'package:voto_mobile/widgets/team/result_card.dart';

class ItemCard extends StatefulWidget {
  final String id;
  final Function()? onBuildComplete;
  const ItemCard({ Key? key, required this.id, this.onBuildComplete }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late DatabaseReference _itemRef;
  Timer? _timer;

  Future<void> _updateLastModified() async {
    final String? teamId = Provider.of<PersistentState>(context, listen: false).currentTeam!.id;
    final modified = DateTime.now().toIso8601String();
    await FirebaseDatabase.instance
        .ref('items/${widget.id}')
        .update({'last_modified': modified});
    await FirebaseDatabase.instance
        .ref('teams/$teamId/items')
        .update({widget.id: modified});
    _timer = null;
  }

  @override
  void initState() {
    super.initState();
    _itemRef = FirebaseDatabase.instance.ref('items/${widget.id}');
  }

  @override
  void didUpdateWidget(covariant ItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _itemRef = FirebaseDatabase.instance.ref('items/${widget.id}');
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _itemRef.onValue,
      builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        WidgetsBinding.instance?.addPostFrameCallback((_) => widget.onBuildComplete?.call());
        if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
          /***
           * Convert data
           */
          final json = snapshot.data?.snapshot.value as Map<dynamic, dynamic>;
          final item = Items.fromJson(json);
          item.id = widget.id;
          item.pollSettings!.closeDateFormatted = DateFormat.yMMMd()
              .add_Hm()
              .format(item.pollSettings!.closeDate ?? DateTime.now());
          final bool isClosed =
              item.pollSettings!.closeDate!.isBefore(DateTime.now()) ||
                  item.closed != null;
          
          /***
           * Set timer
           */

          _timer?.cancel();

          if (isClosed) {
            return ResultCard(item: item);
          } else {
            _timer = Timer(
              item.pollSettings!.closeDate!.difference(DateTime.now()),
              _updateLastModified);
            if (item.type == 'poll') {
              return PollCard(item: item);
            } else if (item.type == 'random') {
              return RandomCard(item: item);
            }
          }
        }
        return Container();
      },
    );
  }
}