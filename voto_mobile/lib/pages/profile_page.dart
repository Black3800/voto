import 'package:flutter/material.dart';
import 'package:voto_mobile/widgets/profile/profile_button.dart';
import 'package:voto_mobile/widgets/profile/profile_display_name.dart';
import 'package:voto_mobile/widgets/profile/profile_name_edit.dart';
import 'package:voto_mobile/widgets/profile/profile_picture_edit.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
            children: const [
              ProfilePictureEditing(),
              ProfileDisplayName(),
              ProfileDisplayNameEditing(),
            ],
          ),
          const ProfileButton(),
        ],
      ),
    );
  }
}
