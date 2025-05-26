import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(Uint8List?) onImagePicked;

  const ImagePickerWidget({super.key, required this.onImagePicked});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  Uint8List? _image;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      final bytes = await picked.readAsBytes();
      setState(() => _image = bytes);
      widget.onImagePicked(bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _image != null
            ? Image.memory(_image!, height: 150)
            : const Icon(Icons.image, size: 150, color: Colors.grey),
        TextButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.camera_alt),
          label: const Text('Tomar foto'),
        ),
      ],
    );
  }
}
