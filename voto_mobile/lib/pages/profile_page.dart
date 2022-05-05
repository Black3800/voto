import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:voto_mobile/model/users.dart';
import 'package:voto_mobile/widgets/image_input.dart';
import 'package:voto_mobile/widgets/profile/profile_button.dart';
import 'package:voto_mobile/widgets/profile/profile_display_name.dart';
import 'package:voto_mobile/widgets/profile/profile_name_edit.dart';
import 'package:voto_mobile/widgets/profile/profile_picture_edit.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? displayName;
  String? email;
  String? image;

  Future<void> _getProfile() async {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user != null) {
        String uid = user.uid;
        DatabaseReference ref = FirebaseDatabase.instance.ref('users/$uid');
        ref.onValue.listen((event) {
          if(event.snapshot.exists) {
            final json = event.snapshot.value as Map<dynamic, dynamic>;
            Users data = Users.fromJson(json);
            setState(() {
              displayName = data.displayName;
              email = user.email;
              image = data.img;
            });
          }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    
    return VotoScaffold(
      title: 'Edit profile',
      useMenu: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ImageInput(
                  image: image ?? 'gs://cs21-voto.appspot.com/dummy/blank.webp',
                  radius: 150.0,
                  onChanged: (newPath) {
                    // setState(() => createTeamImage = newPath);
                  },
                ),
              ),
              ProfileDisplayName(name: displayName ?? ''),
              ProfileDisplayNameEditing(name: displayName ?? '', email: email ?? ''),
            ],
          ),
          const ProfileButton(),
        ],
      ),
    );
  }
}
