import 'package:flutter/material.dart';
import 'package:voto_mobile/widgets/confirm_button.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class AddOptionPage extends StatefulWidget {
  const AddOptionPage({ Key? key }) : super(key: key);

  @override
  State<AddOptionPage> createState() => _AddOptionPageState();
}

class _AddOptionPageState extends State<AddOptionPage> {
  @override
  Widget build(BuildContext context) {
    return VotoScaffold(
        useMenu: false,
        title: 'Add option', 
        titleContext: 'Integrated Project II',
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 42.5,
                  right: 42.5
                ),
                child: const Text('Implement me'),
              )
            ),
            ConfirmButton(
              confirmText: 'Create',
              cancelText: 'Back',
              onConfirm: () {
                Navigator.popUntil(context, ModalRoute.withName('/team_page'));
              },
              onCancel: () {
                Navigator.pop(context);
              },
              height: 75.0
            )
          ]
        )
    );
  }
}