import 'package:flutter/material.dart';
import 'dart:math';
import 'package:voto_mobile/utils/color.dart';

class ImageInput extends StatefulWidget {
  final double radius;
  final String? image;
  final String? initial;
  const ImageInput({Key? key, this.image, this.initial, this.radius = 120.0}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  @override
  Widget build(BuildContext context) {
    double position = widget.radius * sin(pi/4);
    double size = position + widget.radius / 3;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(children: [
        widget.image != null ? CircleAvatar(
          backgroundImage: AssetImage(widget.image ?? ''),
          radius: widget.radius
        ) : CircleAvatar(
          backgroundColor: VotoColors.indigo[300],
          child: Text(widget.initial ?? '', style: Theme.of(context).textTheme.headline1),
          radius: widget.radius
        ),
        Positioned(
            top: position,
            left: position,
            child: Container(
              height: widget.radius / 3,
              width: widget.radius / 3,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: VotoColors.primary,
              ),
              child: IconButton(
                icon: const Icon(Icons.camera_alt),
                iconSize: widget.radius / 6,
                onPressed: () {},
                color: VotoColors.white,)
            )),
      ]),
    );
  }
}
