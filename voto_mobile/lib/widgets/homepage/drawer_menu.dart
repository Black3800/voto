import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/homepage/logout_card.dart';
import 'package:voto_mobile/widgets/homepage/profile_card.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PersistentState>(context, listen: false).currentUser!;
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        children: [
          SizedBox(
            height: 80.0,
            child: DrawerHeader(
              child: headerDrawerMenu(context),
              margin: const EdgeInsets.all(0.0),
              padding: const EdgeInsets.all(0.0),
            ),
          ),
          ProfileCard(
              imagePath: user.img!,
              title: user.displayName!,
              onTap: () {
                Navigator.of(context).popAndPushNamed('/profile_page');
              }),
          const LogoutCard(),
        ],
      ),
    );
  }

  Widget headerDrawerMenu(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            size: 32.0,
          ),
          iconSize: 32.0,
          color: VotoColors.indigo,
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'Menu',
            style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: VotoColors.indigo),
          ),
        )),
      ],
    );
  }
}
