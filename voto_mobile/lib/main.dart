import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/pages/pages.dart';
import 'package:voto_mobile/utils/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PersistentState>(
      create: (BuildContext context) => PersistentState(),
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
        initialRoute: '/login_page',
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
  }
}
