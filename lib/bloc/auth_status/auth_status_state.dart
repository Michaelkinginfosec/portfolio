import 'package:portfolio/datasource/models/user_model.dart';

abstract class AuthStatusState {}

class AuthStatusInitial extends AuthStatusState {}

class AuthStatusLoading extends AuthStatusState {}

class Auththenticated extends AuthStatusState {
  final UserModel user;
  Auththenticated(this.user);
}

class Unauthenticated extends AuthStatusState {}
