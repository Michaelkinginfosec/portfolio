import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/auth_status/auth_status_event.dart';
import 'package:portfolio/bloc/auth_status/auth_status_state.dart';
import 'package:portfolio/datasource/repository/respository.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  final LoginRepository loginRepository;

  AuthStatusBloc({required this.loginRepository}) : super(AuthStatusInitial()) {
    on<CheckAuthStatus>(_onCheckAuthStatus);
    on<Logout>(_onLogout);
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthStatusState> emit,
  ) async {
    emit(AuthStatusLoading());

    final user = await loginRepository.me();

    if (user != null) {
      emit(Auththenticated(user));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogout(Logout event, Emitter<AuthStatusState> emit) async {
    emit(Unauthenticated());
  }
}
