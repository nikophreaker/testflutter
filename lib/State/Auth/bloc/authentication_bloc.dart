import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/State/Auth/bloc/authentication_event.dart';
import 'package:flutter_application_1/State/Auth/bloc/authentication_state.dart';
import 'package:flutter_application_1/State/Auth/repositories/auth_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;

  AuthenticationBloc(super.initialState, {required this.authRepository})
      : assert(authRepository != null);

  AuthenticationState get initialState => const AuthenticationInitial();

  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    // if (event is AppStarted) {
    //   final hasToken = await authRepository.hasToken();

    //   if (hasToken) {
    //     authRepository.addInterceptor(await authRepository.getToken(), this);
    //     yield const AuthenticationAuthenticated();
    //   } else {
    //     yield const AuthenticationUnauthenticated();
    //   }
    // }

    // if (event is LoggedIn) {
    //   await authRepository.persistToken(event.token);
    //   authRepository.addInterceptor(event.token, this);
    //   yield const AuthenticationAuthenticated();
    // }

    // if (event is LoggedOut) {
    //   try {
    //     await authRepository.deAuthenticate();
    //   } finally {
    //     await authRepository.deleteToken();
    //     yield const AuthenticationUnauthenticated();
    //   }
    // }
    // if (event is TokenExpired) {
    //   await authRepository.deleteToken();
    //   yield const ForcedAuthenticated();
    //   yield const AuthenticationUnauthenticated();
    // }
  }
}
