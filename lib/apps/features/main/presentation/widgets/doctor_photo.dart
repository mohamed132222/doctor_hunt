import 'package:flutter/material.dart';

import '../../data/models/doctor.dart';

/// Doctor photo on a themed circular/rounded background with a person
/// placeholder when no asset is set.
class DoctorPhoto extends StatelessWidget {
  const DoctorPhoto({super.key, required this.doctor, required this.iconSize});

  final Doctor doctor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final image = doctor.image;

    final Widget child = image == null
        ? Center(
            child: Icon(
              Icons.person,
              size: iconSize,
              color: scheme.onPrimaryContainer,
            ),
          )
        : Image.asset(
            image,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Icon(
                Icons.person,
                size: iconSize,
                color: scheme.onPrimaryContainer,
              ),
            ),
          );

    return ColoredBox(color: scheme.primaryContainer, child: child);
  }
}
