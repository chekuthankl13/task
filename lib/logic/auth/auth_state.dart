// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoadError extends AuthState {
  final String error;
  const AuthLoadError({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}

class AuthLoginSucess extends AuthState {
  final CredentialModel cred;
  const AuthLoginSucess({
    required this.cred,
  });

  @override
  List<Object> get props => [cred];
}

class AuthRegisterSucess extends AuthState {
  final CredentialModel cred;

  const AuthRegisterSucess({required this.cred});
  @override
  List<Object> get props => [cred];
}
