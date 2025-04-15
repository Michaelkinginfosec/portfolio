import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/bloc/auth/auth_event.dart';
import 'package:portfolio/bloc/auth/auth_state.dart';
import 'package:portfolio/datasource/repository/respository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository _loginRepository;
  LoginBloc(this._loginRepository) : super(LoginInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await _loginRepository.login(
          event.email,
          event.password,
        );
        emit(LoginSuccess(response));
      } catch (error) {
        emit(LoginFailed(error.toString()));
      }
    });
  }
}
