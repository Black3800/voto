import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/homepage/logout_card.dart';
import 'package:voto_mobile/widgets/homepage/profile_card.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
              height: 150,
              child: DrawerHeader(
                child: headerDrawerMenu(context),
              )),
          ProfileCard(
              imagePath: 'assets/user_profile_test.jpg',
              title: 'Tanny Panitnun',
              onTap: () {
                Navigator.pushNamed(context, "/profile_page");
              }),
          const LogoutCard(),
        ],
      ),
    );
  }

  Widget headerDrawerMenu(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: () {
                // Navigator.pushNamed(context, "/home_page");
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                size: 32.0,
              ),
              color: VotoColors.indigo),
        ),
        Expanded(
            flex: 4,
            child: Container(
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                'Menu',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: VotoColors.indigo),
              ),
            )),
      ],
    );
  }
}
