part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class GoogleSignInRequested extends AuthEvent {
  const GoogleSignInRequested();
}

final class CheckAuthStatusRequested extends AuthEvent {
  const CheckAuthStatusRequested();
}
