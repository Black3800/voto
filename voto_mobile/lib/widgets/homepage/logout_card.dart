import 'package:flutter/material.dart';
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
              Navigator.pushNamed(context, "/login_page");
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.logout,
                          color: VotoColors.indigo,
                          size: 32.0,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'Logout',
                          style: TextStyle(
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
