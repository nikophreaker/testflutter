import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  const AppStarted();
}

class LoggedIn extends AuthenticationEvent {
  final String token;

  const LoggedIn({required this.token});

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthenticationEvent {
  const LoggedOut();
}

class TokenExpired extends AuthenticationEvent {
  const TokenExpired();
}
