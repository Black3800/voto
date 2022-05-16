import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:voto_mobile/model/persistent_state.dart';
import 'package:voto_mobile/model/users.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/confirm_button.dart';
import 'package:voto_mobile/widgets/image_input.dart';
import 'package:voto_mobile/widgets/profile/profile_display_name.dart';
import 'package:voto_mobile/widgets/profile/profile_name_edit.dart';
import 'package:voto_mobile/widgets/voto_scaffold.dart';
import 'package:voto_mobile/widgets/voto_snackbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late DatabaseReference _userRef;
  late String userImage;
  late String initialName;
  late String initialImage;
  String? uid;
  String? displayName;
  String? email;
  String? image;
  bool isSaved = false;

  Future<void> _updateImage(String path) async {
    userImage = path;
    await _userRef.update({
      "img": path
    });
  }

  Future<void> _updateProfile() async {
    FocusScope.of(context).unfocus();
    final String userDisplayName = _nameController.text;
    if (userDisplayName.isEmpty) {
      VotoSnackbar(
        text: 'Display name is required',
        icon: Icons.clear,
        accentColor: VotoColors.danger
      ).show(context);
      return;
    }
    /***
     * Update in Realtime DB
     */
    await _userRef.update({
      "display_name": userDisplayName
    });
    /***
     * Update FirebaseAuth
     */
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        user.updateDisplayName(userDisplayName);
      }
    });
    /***
     * Update in Provider
     */
    final _user = Provider.of<PersistentState>(context, listen: false).currentUser!;
    _user.displayName = userDisplayName;
    _user.img = userImage;
    Provider.of<PersistentState>(context, listen: false).updateUser(_user);
    /***
     * Delete initial image if a new image is set
     */
    if (userImage != initialImage) {
      await FirebaseStorage.instance.ref(initialImage).delete();
    }
    isSaved = true;
  }

  Future<bool> _handlePop() async {
    if (userImage != initialImage) {
      if (!isSaved) {
        // await FirebaseStorage.instance.ref(userImage).delete();
        await _userRef.update({"img": initialImage});
      }
    }
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    initialName = Provider.of<PersistentState>(context, listen: false).currentUser!.displayName!;
    initialImage = Provider.of<PersistentState>(context, listen: false).currentUser!.img!;
    userImage = initialImage;
    uid = Provider.of<PersistentState>(context, listen: false).currentUser!.uid!;
    _nameController = TextEditingController(text: initialName);
    _emailController = TextEditingController(
        text: Provider.of<PersistentState>(context, listen: false)
            .currentUser!
            .email!);
    _userRef = FirebaseDatabase.instance.ref('users/$uid');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VotoScaffold(
      title: 'Edit profile',
      useMenu: false,
      onWillPop: _handlePop,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: _userRef.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator()),
                    );
                  } else if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
                    final data = snapshot.data?.snapshot.value as Map;
                    final user = Users.fromJson(data);
                    print(user.img);
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: ImageInput(
                            image: user.img!,
                            radius: 150.0,
                            notDeleteable: initialImage,
                            onChanged: (newPath) {
                              if (newPath.isNotEmpty) _updateImage(newPath);
                            },
                          ),
                        ),
                        Text(
                            user.displayName!,
                            style: GoogleFonts.inter(
                                fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        ProfileDisplayNameEditing(
                            nameController: _nameController,
                            emailController: _emailController),
                      ],
                    );
                  }
                  return Container();
                }
              ),
            ),
          ),
          ConfirmButton(
              confirmText: 'Save',
              onConfirm: () async {
                await _updateProfile();
                await _handlePop();
                Navigator.of(context).pop();
              },
              onCancel: () async {
                await _handlePop();
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }
}
