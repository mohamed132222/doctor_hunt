import 'package:doctor_hunt/apps/core/di/injection.dart';
import 'package:doctor_hunt/apps/features/admin/settings/presentation/controllers/admin_profile/admin_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminProfileScope extends StatefulWidget {
  const AdminProfileScope({super.key, required this.child});

  final Widget child;

  @override
  State<AdminProfileScope> createState() => _AdminProfileScopeState();
}

class _AdminProfileScopeState extends State<AdminProfileScope> {
  @override
  void initState() {
    super.initState();
    getIt<AdminProfileCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminProfileCubit>.value(
      value: getIt<AdminProfileCubit>(),
      child: widget.child,
    );
  }
}
