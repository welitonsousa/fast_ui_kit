import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
export 'package:file_picker/file_picker.dart';
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
  static Future<List<PlatformFile>?> picker({
    FastPickerType type = FastPickerType.image,
    List<String>? accept,
    bool multiple = false,
    bool allowCompression = false,
    int compressionQuality = 0,
    String? dialogTitle,
    String? initialDirectory,
    bool lockParentWindow = false,
    dynamic Function(FilePickerStatus)? onFileLoading,
    bool readSequential = false,
    bool withData = false,
bool withReadStream = false,


  }) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: multiple,
        type: type._picker,
        allowedExtensions: accept,
        allowCompression: allowCompression,
        compressionQuality: compressionQuality,
        dialogTitle: dialogTitle,
        initialDirectory: initialDirectory,
        lockParentWindow:  lockParentWindow,
        onFileLoading: onFileLoading,
        readSequential: readSequential,
        withData: withData,
        withReadStream: withReadStream
      );
      if (result != null) {
        return result.files;
      }
    } on UnimplementedError {
      throw 'Unimplemented method channel -> please, uninstall your app and install again.';
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
