import 'package:doctor_hunt/apps/core/widgets/avatar.dart';
import 'package:doctor_hunt/apps/features/common/doctors/data/models/doctor_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/extensions/media_query_extension.dart';

class SpecialtyDoctorCard extends StatelessWidget {
  const SpecialtyDoctorCard({super.key, required this.doctor, this.onTap});

  final Doctor doctor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final radius = BorderRadius.circular(context.r16);

    return Material(
      color: scheme.surface,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Padding(
          padding: EdgeInsets.all(context.s12),
          child: Row(
            children: [
              PhotoAvatar(
                size: context.bookingCardPhoto,
                imagePath: doctor.photo,
                shape: AvatarShape.rounded,
                radius: context.adminDoctorCardPhotoRadius,
              ),
              SizedBox(width: context.s12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: theme.textTheme.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.s2),
                    Text(
                      doctor.specialty.label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.s6),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: context.iconSmall,
                          color: scheme.primary,
                        ),
                        SizedBox(width: context.s4),
                        Text(
                          '${doctor.rating.toStringAsFixed(1)} · '
                          '${doctor.reviewsCount}',
                          style: theme.textTheme.labelSmall,
                        ),
                        const Spacer(),
                        Text(
                          '\$${doctor.fee.toStringAsFixed(2)}',
                          style: theme.textTheme.titleSmall?.copyWith(
                            color: scheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
