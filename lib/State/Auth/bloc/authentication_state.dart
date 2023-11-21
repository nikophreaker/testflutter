import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];

  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated();
}

class AuthenticationUnauthenticated extends AuthenticationState {
  const AuthenticationUnauthenticated();
}

class ForcedAuthenticated extends AuthenticationState {
  const ForcedAuthenticated();
}
