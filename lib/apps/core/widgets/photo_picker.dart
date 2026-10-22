import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doctor_hunt/generated/strings.g.dart';

Future<String?> pickPhoto(BuildContext context) async {
  final scheme = Theme.of(context).colorScheme;

  final source = await showModalBottomSheet<ImageSource>(
    context: context,
    backgroundColor: scheme.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library_outlined),
            title: Text(t.adminGalleryOption),
            onTap: () => Navigator.of(sheetContext).pop(ImageSource.gallery),
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: Text(t.adminCameraOption),
            onTap: () => Navigator.of(sheetContext).pop(ImageSource.camera),
          ),
        ],
      ),
    ),
  );

  if (source == null) return null;

  final file = await ImagePicker().pickImage(
    source: source,
    maxWidth: 1080,
    imageQuality: 85,
  );
  return file?.path;
}
