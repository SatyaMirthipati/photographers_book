import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ImagePickerType {
  photo,
  multiplePhoto,
  video,
}

class ImagePickerContainer extends StatefulWidget {
  final Widget child;
  final Function(BuildContext context, File? image) onPick;
  final ImagePickerType type;

  static Future<File?> getImage(
    context,
    ImageSource imageSource,
  ) async {
    var picker = ImagePicker();
    var image = await picker.pickImage(
      source: imageSource,
      imageQuality: 95,
      maxWidth: 2048,
      maxHeight: 1536,
    );
    if (Platform.isAndroid) {
      final response = await picker.retrieveLostData();
      if (response.isEmpty) {
        return image == null ? null : File(image.path);
      }
      if (response.file != null) {
        image = response.file;
      } else {
        var error = response.exception?.code;
        print(error);
      }
      return image == null ? null : File(image.path);
    } else {
      return image == null ? null : File(image.path);
    }
  }

  static Future<List<File>?> getImages(context) async {
    var picker = ImagePicker();
    var images = await picker.pickMultiImage(
      imageQuality: 95,
      maxWidth: 2048,
      maxHeight: 1536,
    );
    if (Platform.isAndroid) {
      final response = await picker.retrieveLostData();
      if (response.isEmpty) {
        var error = response.exception?.code;
        if (kDebugMode) {
          print(error);
        }
      } else {
        images = response.files!;
      }
    }
    return images.map((e) => File(e.path)).toList();
  }

  static Future<File?> getVideo(
    context,
    ImageSource imageSource, {
    Duration? duration,
  }) async {
    var picker = ImagePicker();
    var image = await picker.pickVideo(
      source: imageSource,
      maxDuration: duration,
    );
    if (Platform.isAndroid) {
      final response = await picker.retrieveLostData();
      if (response.isEmpty) {
        return image == null ? null : File(image.path);
      }
      if (response.file != null) {
        image = response.file;
      } else {
        var error = response.exception?.code;
        print(error);
      }
      return image == null ? null : File(image.path);
    } else {
      return image == null ? null : File(image.path);
    }
  }

  const ImagePickerContainer({
    Key? key,
    required this.child,
    required this.onPick,
    this.type = ImagePickerType.photo,
  }) : super(key: key);

  @override
  _ImagePickerContainerState createState() => _ImagePickerContainerState();
}

class _ImagePickerContainerState extends State<ImagePickerContainer> {
  void showChoiceDialog(context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Pick image from?', textAlign: TextAlign.center),
          children: <Widget>[
            TextButton(
              onPressed: () async {
                var file = await ImagePickerContainer.getImage(
                  context,
                  ImageSource.camera,
                );
                widget.onPick(context, file);
                Navigator.pop(context);
              },
              child: const Text('CAMERA'),
            ),
            TextButton(
              onPressed: () async {
                var file = await ImagePickerContainer.getImage(
                  context,
                  ImageSource.gallery,
                );
                widget.onPick(context, file);
                Navigator.pop(context);
              },
              child: const Text('GALLERY'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => showChoiceDialog(context),
      child: widget.child,
    );
  }
}
