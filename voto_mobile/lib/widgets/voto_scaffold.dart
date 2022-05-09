import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/homepage/drawer_menu.dart';

class VotoScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final String? titleContext;
  final bool useMenu;
  final bool useSetting;
  final Future<bool> Function()? onWillPop;

  const VotoScaffold({
    Key? key,
    required this.title,
    required this.body,
    this.titleContext,
    this.useMenu = true,
    this.useSetting = false,
    this.onWillPop
  }) : super(key: key);

  @override
  State<VotoScaffold> createState() => _VotoScaffoldState();
}

class _VotoScaffoldState extends State<VotoScaffold> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.onWillPop ?? () async => true,
      child: Scaffold(
        key: _key,
        drawer: const DrawerMenu(),
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headline1,
              ),
              widget.titleContext != null
                  ? Text(
                      widget.titleContext ?? '',
                      style: GoogleFonts.inter(
                          fontSize: 16, color: VotoColors.white),
                    )
                  // fontSize: 16.0, color: VotoColors.white,fontFamily: GoogleFonts.inter),
    
                  : Container()
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          titleSpacing: 10.0,
          toolbarHeight: 87.0,
          leading: widget.useMenu
              ? IconButton(
                  icon: const Icon(Icons.menu),
                  iconSize: 32.0,
                  onPressed: () {
                    _key.currentState!.openDrawer();
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.chevron_left),
                  iconSize: 32.0,
                  onPressed: () {
                    if(widget.onWillPop != null) {
                      widget.onWillPop!().then((willPop) {
                        if(willPop) Navigator.of(context).pop();
                      });
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                ),
          leadingWidth: widget.useMenu ? 90.0 : 50.0,
          actions: widget.useSetting
              ? <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        icon: const Icon(Icons.settings),
                        iconSize: 32.0,
                        onPressed: () {
                          Navigator.pushNamed(context, '/manage_team_page');
                        },
                      ))
                ]
              : <Widget>[],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        body: widget.body,
        backgroundColor: VotoColors.white,
      ),
    );
  }
}
