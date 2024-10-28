import 'dart:io';
import 'package:fast_ui_kit/fast_ui_kit.dart';
import 'package:flutter/material.dart';

class FastFormAvatarFile extends StatefulWidget {
  final bool showRemoveButton;
  final BoxFit? fit;
  final double size;
  final Widget? emptyWidget;
  final void Function(PlatformFile?)? onChanged;
  final FastFileInitialData? initialValue;
  final String? Function(PlatformFile?)? validator;

  /// FastFormAvatarFile is used to select a file
  ///
  ///
  /// [showRemoveButton] is used to define if the remove button will be displayed
  ///
  ///
  /// [onChanged] is used to define the callback when the file is selected
  ///
  ///
  ///
  /// [validator] is used to define the validator of the field
  ///
  /// example:
  ///
  /// ```dart
  ///  FastFormAvatarFile(
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
  const FastFormAvatarFile({
    super.key,
    this.onChanged,
    this.emptyWidget,
    this.showRemoveButton = true,
    this.validator,
    this.size = 100,
    this.fit = BoxFit.cover,
    this.initialValue,
  });

  @override
  State<FastFormAvatarFile> createState() => _FastFormAvatarFileState();
}

class _FastFormAvatarFileState extends State<FastFormAvatarFile> {
  FastFileInitialData? initialValue;

  @override
  initState() {
    super.initState();
    initialValue = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant FastFormAvatarFile oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initialValue?.path != widget.initialValue?.path) {
      initialValue = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<PlatformFile>(
      validator: widget.validator,
      builder: (field) {
        return Align(
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: field.hasError ? Colors.red[900]! : Colors.grey,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () async {
                final files = await FastPickerService.picker(
                  type: FastPickerType.image,
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
                  if (field.value != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.file(
                        File(field.value!.path!),
                        height: widget.size,
                        width: widget.size,
                        fit: widget.fit,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.percent);
                        },
                      ),
                    )
                  else if (initialValue != null)
                    if (initialValue!.isFile)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          File(initialValue!.path),
                          height: widget.size,
                          width: widget.size,
                          fit: widget.fit,
                        ),
                      )
                    else if (initialValue!.isNetwork)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          initialValue!.path,
                          height: widget.size,
                          width: widget.size,
                          fit: widget.fit,
                        ),
                      )
                    else if (initialValue!.isAsset)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          initialValue!.path,
                          height: widget.size,
                          width: widget.size,
                          fit: widget.fit,
                        ),
                      ),
                  if (field.value == null && initialValue == null)
                    widget.emptyWidget ??
                        Center(
                          child: Icon(
                            FastIcons.awesome.user,
                            size: widget.size / 2,
                          ),
                        ),
                  if (widget.showRemoveButton &&
                      (field.value != null || initialValue != null))
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5, right: 5),
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
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
