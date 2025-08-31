import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SnapCalculatorController {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String _recognizedText = 'No expression detected.';
  String _result = '';

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
    }
  }

  void _clearImageAndResult() {
    _selectedImage = null;
    _recognizedText = 'No expression detected.';
    _result = '';
  }

  void _performCalculation() {
    _recognizedText = 'Recognized: 2+2';
    _result = '4';
  }
}
