import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/model/team.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/bottom_dialog.dart';
import 'package:voto_mobile/widgets/image_input.dart';
import 'package:voto_mobile/widgets/simple_text_input.dart';
import 'package:voto_mobile/widgets/voto_snackbar.dart';
import 'package:voto_mobile/widgets/wide_button.dart';

class EnterPasscodeDialog extends StatefulWidget {
  const EnterPasscodeDialog({
    Key? key,
    required this.team,
    required this.onSuccess
  }) : super(key: key);

  final Team team;
  final Function onSuccess;

  @override
  State<EnterPasscodeDialog> createState() => _EnterPasscodeDialogState();
}

class _EnterPasscodeDialogState extends State<EnterPasscodeDialog> {

  final TextEditingController _passcodeController = TextEditingController();
  String? _error;

  void _verifyPasscode() {
    if(_passcodeController.text == widget.team.passcode) {
      setState(() => _error = null);
      widget.onSuccess();
      Navigator.pop(context);
    } else {
      setState(() => _error = 'Incorrect passcode');
    }
  }

  @override
  void dispose() {
    _passcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BottomDialog(
      title: "Enter passcode",
      height: 0.65,
      child: ListView.separated(
        itemBuilder: (context, index) => [
          Text("The following team requires passcode to join",
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.merge(GoogleFonts.inter(color: VotoColors.black))),
          Center(
              child: ImageInput(
            image: widget.team.img,
            readOnly: true,
          )),
          Center(
            child: Text(widget.team.name,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    ?.merge(GoogleFonts.inter(color: VotoColors.black))),
          ),
          Text("Passcode",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.merge(GoogleFonts.inter(color: VotoColors.black))),
          SimpleTextInput(
            controller: _passcodeController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            accentColor: VotoColors.indigo,
            errorText: _error,
            max: 4,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: WideButton(
                text: 'Join',
                onPressed: _verifyPasscode),
          ),
        ][index],
        separatorBuilder: (context, index) => const SizedBox(height: 15.0),
        itemCount: 6
      ),
    );
  }
}