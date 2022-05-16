import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/model/users.dart';
import 'package:voto_mobile/widgets/image_input.dart';
import 'package:voto_mobile/widgets/manageteamowner/kick_button.dart';

class Membercard extends StatefulWidget {
  final String? id;
  final String? name;
  final String? image;
  final bool isOwner;
  final bool kickable;
  /// If the [id] is not supplied, both [name] and [image] must be
  const Membercard(
      {Key? key,
      this.id,
      this.name,
      this.image,
      this.isOwner = false,
      this.kickable = false})
      : super(key: key);

  @override
  State<Membercard> createState() => _MembercardState();
}

class _MembercardState extends State<Membercard> {
  late Future<Users> _userInfo;

  Future<Users> _getUserInfo() async {
    final snapshot = await FirebaseDatabase.instance.ref('users/${widget.id}').get();
    final data = snapshot.value as Map;
    final user = Users.fromJson(data);
    user.uid = widget.id;
    return user;
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      _userInfo = _getUserInfo();
    } else {
      _userInfo = Future.value(Users(displayName: widget.name!, img: widget.image!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userInfo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data as Users;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: ImageInput(
                  image: user.img!,
                  radius: 40,
                  readOnly: true,
                  showLoadingStatus: false,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.displayName!,
                        style: GoogleFonts.inter(fontSize: 14),
                      ),
                      widget.isOwner
                          ? Text(
                              "Team owner",
                              style:
                                  GoogleFonts.inter(color: const Color(0xff989898), fontSize: 12),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
              widget.kickable ? const KickButton() : Container()
            ],
          );
        } else {
          return Container();
        }
      }
    );
  }
}
