import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerUtils {
  
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx']
    );
    if (result == null) {
      return null;
    } else {
      return File(result.files.single.path!);
    }
  }
}