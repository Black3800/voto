import 'package:flutter/material.dart';
import 'package:voto_mobile/utils/color.dart';
import 'package:voto_mobile/widgets/homepage/drawer_menu.dart';

class VotoScaffold extends StatefulWidget {
  final String title;
  final Widget body;
  final String? titleContext;
  final bool useMenu;
  final bool useSetting;

  const VotoScaffold(
      {Key? key,
      required this.title,
      required this.body,
      this.titleContext,
      this.useMenu = true,
      this.useSetting = false})
      : super(key: key);

  @override
  State<VotoScaffold> createState() => _VotoScaffoldState();
}

class _VotoScaffoldState extends State<VotoScaffold> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    style: const TextStyle(
                        fontSize: 16.0, color: VotoColors.white),
                  )
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
                  Navigator.pop(context);
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
                      onPressed: () {},
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
    );
  }
}
