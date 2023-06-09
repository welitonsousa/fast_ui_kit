import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

/// use this enum to select the type of file
/// [any] any file
/// [media] any media file
/// [image] only image file
/// [video] only video file
/// [audio] only audio file
/// [custom] custom file type
enum FastPickerType {
  any,
  media,
  image,
  video,
  audio,
  custom;

  FileType get _picker {
    return FileType.values.singleWhere((e) => e.name == name);
  }
}

/// use this class to get file data
/// [path] is the file path
class FileData {
  String path;
  Uint8List data;
  FileData({
    required this.path,
    required this.data,
  });
}

/// use this service to pick files from device
///
/// example:
///
/// ```dart
/// final files = await FastPickerService.picker(
///   type: FastPickerType.image,
///   accept: ['jpg', 'png'],
///   multiple: true,
/// );
/// ```
class FastPickerService {
  static Future<List<FileData>?> picker({
    FastPickerType type = FastPickerType.image,
    List<String>? accept,
    bool multiple = false,
  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: multiple,
        type: type._picker,
        allowedExtensions: accept,
      );
      if (result != null) {
        return result.files.map<FileData>((e) {
          final file = File(e.path!);
          return FileData(
            data: file.readAsBytesSync(),
            path: file.path,
          );
        }).toList();
      }
    } on UnimplementedError {
      throw 'Unimplemented method channel -> please, uninstall your app and install again.';
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
