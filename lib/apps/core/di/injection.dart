import 'package:doctor_hunt/apps/features/common/auth/data/datasources/supabase_data_source.dart';
import 'package:doctor_hunt/apps/features/common/auth/data/repo/auth_repo.dart';
import 'package:doctor_hunt/apps/features/common/auth/presentation/controller/forget_pass/forget_pass_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  getIt.registerLazySingleton<SupabaseDataSource>(
    () => SupabaseDataSource(getIt<SupabaseClient>()),
  );

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepo(getIt<SupabaseDataSource>()),
  );
  getIt.registerFactory<ForgotPasswordBloc>(
    () => ForgotPasswordBloc(getIt<AuthRepo>()),
  );
}
