import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:uuid/uuid.dart';
import 'package:voto_mobile/utils/color.dart';

class ImageInput extends StatefulWidget {
  final String image;
  final String? notDeleteable;
  final double radius;
  final Function(String)? onChanged;
  final bool readOnly;
  final bool showLoadingStatus;
  final bool showBorder;
  const ImageInput({
    Key? key,
    required this.image,
    this.notDeleteable,
    this.onChanged,
    this.radius = 120.0,
    this.readOnly = false,
    this.showLoadingStatus = true,
    this.showBorder = false
  }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  late Future<String?> imageURL;

  Future<String?> _getImageURL() async {
    return Future.value(
      await FirebaseStorage.instance
        .refFromURL(widget.image)
        .getDownloadURL()
    );
  }

  Future<void> _handleInput() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
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
    if (previousImage == widget.notDeleteable) return;
    if (previousImage != null && previousImage.split('/')[3] != 'dummy') {
      FirebaseStorage.instance.ref(previousImage).delete();
    }
  }

  @override
  void initState() {
    super.initState();
    imageURL = _getImageURL();
  }

  @override
  void didUpdateWidget(covariant ImageInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.image.isNotEmpty && widget.image != oldWidget.image) {
      print('delete ${oldWidget.image} for ${widget.image}');
      _deletePreviousImage(oldWidget.image);
    }
    imageURL = _getImageURL();
  }

  @override
  void deactivate() {
    widget.onChanged?.call('');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    double position =
        widget.radius * 0.70710678118; // equals radius * sin(pi/4)
    double size = position + widget.radius / 3;

    return SizedBox(
      width: size,
      height: size,
      child: FutureBuilder(
        future: imageURL,
        builder: (context, snapshot) {
          final bool isLoaded = snapshot.hasData;
          final String? imageURL = snapshot.data as String?;
          return Stack(children: [
            CircleAvatar(
              radius: widget.radius,
              backgroundColor: VotoColors.black.shade400,
              child: CircleAvatar(
                  backgroundImage: isLoaded ? NetworkImage('$imageURL') : null,
                  child: isLoaded || !widget.showLoadingStatus
                        ? null
                        : const CircularProgressIndicator(),
                  backgroundColor: VotoColors.gray,
                  radius: widget.radius - 2),
            ),
            widget.readOnly
                ? Container()
                : Positioned(
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
          ]);
        }
      ),
    );
  }
}
