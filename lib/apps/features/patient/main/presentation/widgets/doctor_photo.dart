import '../../data/models/doctor_model.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

class DoctorPhoto extends StatelessWidget {
  const DoctorPhoto({super.key, required this.doctor, required this.iconSize});

  final Doctor doctor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final image = doctor.image;

    Widget placeholder() => Center(
      child: Icon(
        Icons.person,
        size: iconSize,
        color: scheme.onPrimaryContainer,
      ),
    );

    final Widget child;
    if (image == null || image.isEmpty) {
      child = placeholder();
    } else if (image.startsWith('http')) {
      child = CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        placeholder: (_, _) => placeholder(),
        errorWidget: (_, _, _) => placeholder(),
      );
    } else if (image.startsWith('assets/')) {
      child = Image.asset(
        image,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => placeholder(),
      );
    } else {
      child = Image.file(
        File(image),
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => placeholder(),
      );
    }

    return ColoredBox(color: scheme.primaryContainer, child: child);
  }
}
