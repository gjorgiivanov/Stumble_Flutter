import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) pickImageFn;

  const UserImagePicker(this.pickImageFn, {Key? key}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;
  var _isFromCamera = true;

  Future<void> _pickImage() async {
    try {
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(
          source: _isFromCamera ? ImageSource.camera : ImageSource.gallery,
          imageQuality: 50,
          maxWidth: 150);
      final pickedImageFile = File(pickedImage!.path);
      if (pickedImageFile != null) {
        setState(() {
          _pickedImage = pickedImageFile;
        });
        widget.pickImageFn(pickedImageFile);
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 55,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          child: _pickedImage == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.camera,
                      ),
                      iconSize: 35,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          _isFromCamera = true;
                          _pickImage();
                        });
                      },
                    ),
                    const Text(
                      "Take a photo",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                )
              : null,
        ),
        TextButton.icon(
          onPressed: () {
            setState(() {
              _isFromCamera = false;
              _pickImage();
            });
          },
          icon: const Icon(Icons.image),
          label: const Text("Add Image"),
        )
      ],
    );
  }
}
