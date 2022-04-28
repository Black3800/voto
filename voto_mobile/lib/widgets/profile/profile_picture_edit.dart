import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';

class ProfilePictureEditing extends StatefulWidget {
  const ProfilePictureEditing({Key? key}) : super(key: key);

  @override
  State<ProfilePictureEditing> createState() => _ProfilePictureEditingState();
}

class _ProfilePictureEditingState extends State<ProfilePictureEditing> {
  late double _deviceHeight;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: const EdgeInsets.only(top: 40),
      height: _deviceHeight * 0.2,
      child: Center(
        child: Stack(children: [
          Container(
            width: 121,
            height: 121,
            decoration: const BoxDecoration(
              // border: Border.all(width: 1, color: VotoColors.primary),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/user_profile_test.jpg'),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: VotoColors.primary,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 18,
                ),
              )),
        ]),
      ),
    );
  }
}
