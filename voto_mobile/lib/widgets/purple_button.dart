import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';

class PurpleButton extends StatefulWidget {
  const PurpleButton({
    Key? key
  }) : super(key: key);

  @override
  State<PurpleButton> createState() => _PurpleButtonState();
}

class _PurpleButtonState extends State<PurpleButton> {

  Timer? _copyTimer;
  String _copyText = 'Copy to clipboard';
  IconData _copyIcon = Icons.copy;
  late String code;

  void _handleCopy() {
    Clipboard.setData(ClipboardData(text: code));
    _copyTimer?.cancel;
    setState(() {
      _copyText = 'Copied';
      _copyIcon = Icons.check;
    });
    _copyTimer = Timer(const Duration(seconds: 3), () {
      _revertCopyState();
    });
  }

  void _revertCopyState() {
    setState(() {
      _copyText = 'Copy to clipboard';
      _copyIcon = Icons.copy;
    });
  }

  @override
  void initState() {
    super.initState();
    code = Provider.of<PersistentState>(context, listen: false).currentTeam!.id!;
  }

  @override
  void dispose() {
    _copyTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: (VotoColors.indigo),
        fixedSize: const Size.fromHeight(35),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: _handleCopy,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(_copyIcon, size: 16),
          const SizedBox(width: 10.0),
          Text(
            _copyText,
            style: GoogleFonts.inter(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
