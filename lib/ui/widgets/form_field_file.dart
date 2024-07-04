import 'dart:io';

import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

/// ShowFileType is used to define how the file will be displayed
enum ShowFileType {
  iconAndName,
  bigIcon,
  iconAndNameOrPreviewWhenImage,
  bigIconOrPreviewWhenImage;

  double get iconSize {
    if (this == ShowFileType.bigIcon) return 150;
    if (this == ShowFileType.bigIconOrPreviewWhenImage) return 150;
    return 18;
  }

  bool showIcon([bool isImage = false]) {
    if (this == ShowFileType.bigIcon) return true;
    if (this == ShowFileType.bigIconOrPreviewWhenImage && !isImage) return true;
    if (this == ShowFileType.iconAndName) return true;
    if (this == ShowFileType.iconAndNameOrPreviewWhenImage && !isImage) {
      return true;
    }
    return false;
  }

  bool showPreview([bool isImage = false]) {
    if (this == ShowFileType.bigIconOrPreviewWhenImage && isImage) return true;
    if (this == ShowFileType.iconAndNameOrPreviewWhenImage && isImage) {
      return true;
    }
    return false;
  }

  bool showName([bool isImage = false]) {
    if (this == ShowFileType.bigIcon) return false;
    if (this == ShowFileType.bigIconOrPreviewWhenImage) return false;
    if (this == ShowFileType.iconAndNameOrPreviewWhenImage && isImage) {
      return false;
    }
    return true;
  }
}

enum _FastType { network, asset, file }

class FastFileInitialData {
  final String path;
  // ignore: library_private_types_in_public_api
  final _FastType type;

  FastFileInitialData.file(this.path) : type = _FastType.file;
  FastFileInitialData.network(this.path) : type = _FastType.network;
  FastFileInitialData.asset(this.path) : type = _FastType.asset;

  bool get isNetwork => type == _FastType.network;
  bool get isAsset => type == _FastType.asset;
  bool get isFile => type == _FastType.file;
}

class FastFormFieldFile extends StatefulWidget {
  final String hint;
  final bool showRemoveButton;
  final ShowFileType showFileType;
  final BoxFit? fit;
  final void Function(FileData?)? onChanged;
  final double radius;
  final List<String>? accepts;
  final FastFileInitialData? initialValue;
  final String? Function(FileData?)? validator;

  /// FastFormFieldFile is used to select a file
  ///
  /// [hint] is used to define the hint text
  ///
  /// [showRemoveButton] is used to define if the remove button will be displayed
  ///
  /// [showFileType] is used to define how the file will be displayed
  ///
  /// [onChanged] is used to define the callback when the file is selected
  ///
  /// [radius] is used to define the radius of the field
  ///
  /// [accepts] is used to define the accepted file types
  ///
  /// [validator] is used to define the validator of the field
  ///
  /// example:
  ///
  /// ```dart
  ///  FastFormFieldFile(
  ///   hint: 'File',
  ///   showRemoveButton: true,
  ///   showFileType: ShowFileType.iconAndNameOrPreviewWhenImage,
  ///   onChanged: (file) {
  ///     print(file);
  ///   },
  ///   validator: (file) {
  ///     if (file == null) return 'File is required';
  ///     return null;
  ///   },
  /// )
  /// ```
  const FastFormFieldFile({
    super.key,
    this.onChanged,
    this.accepts,
    this.hint = 'File',
    this.showFileType = ShowFileType.iconAndNameOrPreviewWhenImage,
    this.showRemoveButton = true,
    this.validator,
    this.radius = 8,
    this.fit = BoxFit.cover,
    this.initialValue,
  });

  @override
  State<FastFormFieldFile> createState() => _FastFormFieldFileState();
}

class _FastFormFieldFileState extends State<FastFormFieldFile> {
  FastFileInitialData? initialValue;

  @override
  initState() {
    super.initState();
    initialValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant FastFormFieldFile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue?.path != widget.initialValue?.path) {
      initialValue = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<FileData>(
      validator: widget.validator,
      builder: (field) {
        final isImage = _FileItem(path: '', size: null).imagesFormats.contains(
            (field.value?.path ?? initialValue?.path)?.split('.').last);
        return InkWell(
          borderRadius: BorderRadius.circular(widget.radius),
          onTap: () async {
            final files = await FastPickerService.picker(
              accept: widget.accepts,
              type: widget.accepts != null
                  ? FastPickerType.custom
                  : FastPickerType.image,
            );
            if (files != null) {
              widget.onChanged?.call(files.first);
              widget.validator?.call(files.first);
              field.didChange(files.first);
              field.validate();
            }
            initialValue = null;
            setState(() {});
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    constraints: const BoxConstraints(minHeight: 50),
                    width: context.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              field.hasError ? Colors.red[900]! : Colors.grey),
                      borderRadius: BorderRadius.circular(widget.radius),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (field.value != null)
                              if (widget.showFileType.showPreview(isImage))
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    widget.radius,
                                  ),
                                  child: Image.file(
                                    File(field.value!.path),
                                    height: 200,
                                    fit: widget.fit,
                                  ),
                                ),
                            if (initialValue != null)
                              if (widget.showFileType.showPreview(isImage))
                                if (initialValue!.type == _FastType.network)
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(widget.radius),
                                    child: Image.network(
                                      initialValue!.path,
                                      height: 200,
                                      fit: widget.fit,
                                    ),
                                  )
                                else if (initialValue!.type == _FastType.asset)
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(widget.radius),
                                    child: Image.asset(
                                      initialValue!.path,
                                      height: 200,
                                      fit: widget.fit,
                                    ),
                                  )
                                else if (initialValue!.type == _FastType.file)
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(widget.radius),
                                    child: Image.file(
                                      File(initialValue!.path),
                                      height: 200,
                                      fit: widget.fit,
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                mainAxisAlignment: (field.value != null ||
                                            initialValue != null) &&
                                        widget.showFileType.iconSize == 150
                                    ? MainAxisAlignment.center
                                    : MainAxisAlignment.start,
                                children: [
                                  if (field.value != null ||
                                      initialValue != null)
                                    if (widget.showFileType.showIcon(isImage) &&
                                        widget.showFileType ==
                                            ShowFileType.bigIcon)
                                      Expanded(
                                          child: _FileItem(
                                        path: field.value?.path ??
                                            initialValue!.path,
                                        size: widget.showFileType.iconSize,
                                      ))
                                    else if (widget.showFileType
                                        .showIcon(isImage))
                                      _FileItem(
                                        path: field.value?.path ??
                                            initialValue!.path,
                                        size: widget.showFileType.iconSize,
                                      ),
                                  if (widget.showFileType.showName(isImage))
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 30),
                                        child: Text(
                                            (field.value?.path ??
                                                        initialValue?.path)
                                                    ?.split('/')
                                                    .last ??
                                                widget.hint,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: context
                                                .theme.textTheme.bodyLarge
                                                ?.copyWith(
                                              color: field.hasError
                                                  ? Colors.red[900]!
                                                  : null,
                                            )),
                                      ),
                                    ),
                                  if (field.value == null &&
                                      initialValue == null)
                                    if (widget.showFileType.index == 3 ||
                                        widget.showFileType.index == 1)
                                      Text(widget.hint,
                                          style: context
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(
                                            color: field.hasError
                                                ? Colors.red[900]!
                                                : null,
                                          )),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (field.hasError && field.errorText != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 5, left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          field.errorText!,
                          style: context.theme.textTheme.bodySmall?.copyWith(
                            color: Colors.red[900],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (widget.showRemoveButton &&
                  (field.value != null || initialValue != null))
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      field.didChange(null);
                      initialValue = null;
                      field.validate();

                      widget.onChanged?.call(null);
                    },
                    icon: const Icon(Icons.delete_rounded),
                    color: Colors.red,
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

class _FileItem extends StatelessWidget {
  final String path;
  final double? size;
  _FileItem({required this.path, required this.size});
  final videosFormats = ['mp4', 'avi', 'mov', 'wmv', 'flv', 'webm'];
  final audiosFormats = ['mp3', 'wav', 'wma', 'aac', 'flac', 'ogg'];
  final imagesFormats = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
  final pdfFormats = ['pdf'];
  final wordFormats = ['doc', 'docx', 'odt'];
  final excelFormats = ['xls', 'xlsx'];
  final powerPointFormats = ['ppt', 'pptx'];

  @override
  Widget build(BuildContext context) {
    final fileName = path.split('?')[0];
    final format = fileName.split('.').last;

    if (pdfFormats.contains(format)) {
      return Icon(FastIcons.mci.file_pdf_outline, size: size);
    }
    if (wordFormats.contains(format)) {
      return Icon(FastIcons.ant.wordfile1, size: size);
    }
    if (excelFormats.contains(format)) {
      return Icon(FastIcons.mci.file_table_outline, size: size);
    }
    if (powerPointFormats.contains(format)) {
      return Icon(FastIcons.mci.file_powerpoint, size: size);
    }
    if (imagesFormats.contains(format)) {
      return Icon(FastIcons.mci.file_image_outline, size: size);
    }
    if (audiosFormats.contains(format)) {
      return Icon(FastIcons.mci.file_music_outline, size: size);
    }
    if (videosFormats.contains(format)) {
      return Icon(FastIcons.mci.file_video_outline, size: size);
    }

    return Icon(FastIcons.mci.file_outline, size: size);
  }
}
