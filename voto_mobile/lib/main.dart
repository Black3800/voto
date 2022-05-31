import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/users.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/pages/pages.dart';
import 'package:voto_mobile/utils/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    runApp(MyApp(user: user));
  });
}

class MyApp extends StatelessWidget {
  final User? user;
  const MyApp({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user != null ? FirebaseDatabase.instance.ref('users/${user!.uid}/img').get() : null,
      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final _persistent = PersistentState();
          _persistent.updateUser(
              Users(
                  uid: user?.uid,
                  displayName: user?.displayName,
                  email: user?.email,
                  img: snapshot.data?.value as String
              )
          );

          return ChangeNotifierProvider<PersistentState>(
            create: (_) => _persistent,
            child: MaterialApp(
              title: 'Vo-To',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  brightness: Brightness.light,
                  primarySwatch: VotoColors.primary,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  textTheme: TextTheme(
                      headline1: GoogleFonts.inter(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                          color: VotoColors.white),
                      headline2: GoogleFonts.inter(
                          fontSize: 18.0, fontWeight: FontWeight.w500),
                      headline3: GoogleFonts.inter(
                          fontSize: 14.0, fontWeight: FontWeight.w500),
                      bodyText1: GoogleFonts.inter(fontSize: 14.0),
                      caption: GoogleFonts.inter(
                          fontSize: 12.0, fontWeight: FontWeight.w300),
                      button: GoogleFonts.inter(
                          fontSize: 12.0, fontWeight: FontWeight.w700))),
              initialRoute: user == null ? '/login_page' : '/home_page',
              routes: {
                '/login_page': (context) => const LoginPage(),
                '/signup_page': (context) => const SignupPage(),
                '/home_page': (context) => const HomePage(),
                '/profile_page': (context) => const ProfilePage(),
                '/team_page': (context) => const TeamPage(),
                '/manage_team_page': (context) => const ManageTeamPage(),
                '/create_item_page': (context) => const CreateItemPage(),
                '/add_option_page': (context) => const AddOptionPage(),
                '/poll_page': (context) => const PollPage(),
                '/random_page': (context) => const RandomPage(),
                '/poll_result_page': (context) => const PollResultPage(),
                '/random_result_page': (context) => const RandomResultPage(),
                // '/manage_team_owner_page': (context) => const ManageTeamOwnerPage(),
              },
            ),
          );
        } else {
          return Container();
        }
      }
    );
  }
}
