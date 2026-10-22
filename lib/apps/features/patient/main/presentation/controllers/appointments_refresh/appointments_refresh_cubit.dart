import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsRefreshCubit extends Cubit<int> {
  AppointmentsRefreshCubit() : super(0);

  void ping() => emit(state + 1);
}
