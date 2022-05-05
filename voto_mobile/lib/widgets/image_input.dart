import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:voto_mobile/utils/color.dart';

class ImageInput extends StatefulWidget {
  final String image;
  final double radius;
  final String? initial;
  final Function(String)? onChanged;
  const ImageInput(
      {Key? key,
      required this.image,
      this.onChanged,
      this.initial,
      this.radius = 120.0})
      : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  String? imageURL;
  bool isLoading = true;

  Future<void> _getImageURL() async {
    imageURL = await FirebaseStorage.instance
        .refFromURL(widget.image)
        .getDownloadURL();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _handleInput() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      if (mounted) setState(() => isLoading = true);
      Uint8List fileBytes = result.files.first.bytes ?? Uint8List(0);
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android) {
        fileBytes = await FlutterImageCompress.compressWithList(
          fileBytes,
          minHeight: 1920,
          minWidth: 1080,
        );
      }
      const uuid = Uuid();
      while (true) {
        String fileName = uuid.v1();
        String path = 'gs://cs21-voto.appspot.com/uploads/$fileName';
        try {
          await FirebaseStorage.instance.ref(path).getDownloadURL();
          debugPrint('duplicate filename exists, getting a new name...');
        } on FirebaseException catch (e) {
          if (e.code == 'object-not-found') {
            await FirebaseStorage.instance.ref(path).putData(fileBytes);
            widget.onChanged?.call(path);
            break;
          }
        }
      }
    }
  }

  Future<void> _deletePreviousImage(String? previousImage) async {
    /***
     * Delete previousImage if not in /dummy folder
     */
    if (previousImage != null && previousImage.split('/')[3] != 'dummy') {
      FirebaseStorage.instance.ref(previousImage).delete();
    }
  }

  @override
  void initState() {
    super.initState();
    _getImageURL();
  }

  @override
  void didUpdateWidget(covariant ImageInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    _deletePreviousImage(oldWidget.image);
    _getImageURL();
  }

  @override
  Widget build(BuildContext context) {
    double position =
        widget.radius * 0.70710678118; // equals radius * sin(pi/4)
    double size = position + widget.radius / 3;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(children: [
        CircleAvatar(
            backgroundImage: isLoading ? null : NetworkImage(imageURL ?? ''),
            backgroundColor: VotoColors.gray,
            child: isLoading
                ? Text('Loading',
                    style: GoogleFonts.inter(color: VotoColors.black.shade300))
                : null,
            radius: widget.radius),
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
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt),
                    iconSize: widget.radius / 6,
                    onPressed: _handleInput,
                    color: VotoColors.white,
                  ),
                ))),
      ]),
    );
  }
}
