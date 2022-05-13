import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/utils/color.dart';

class LogoutCard extends StatelessWidget {
  const LogoutCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: VotoColors.indigo.shade400),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 5.0,
                offset: Offset(1.0, 2.0))
          ],
          color: VotoColors.white,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            splashColor: VotoColors.indigo.shade100,
            onTap: () {
              FirebaseAuth.instance.signOut();
              Provider.of<PersistentState>(context, listen: false).disposeUser();
              Navigator.popUntil(context, ModalRoute.withName('/login_page'));
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children:  [
                        Icon(
                          Icons.logout,
                          color: VotoColors.indigo,
                          size: 32.0,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'Logout',
                          style: GoogleFonts.inter(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                              color: VotoColors.indigo),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: VotoColors.indigo,
                      size: 32.0,
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
