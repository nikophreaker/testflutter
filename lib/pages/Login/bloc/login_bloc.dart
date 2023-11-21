import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Login/bloc/login_event.dart';
import 'package:flutter_application_1/Pages/Login/bloc/login_state.dart';
import 'package:flutter_application_1/State/Auth/bloc/authentication_bloc.dart';
import 'package:flutter_application_1/State/Auth/bloc/authentication_event.dart';
import 'package:flutter_application_1/State/Auth/repositories/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  // final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.authRepository,
  }) : super(const LoginInitial());

  LoginState get initialState => const LoginInitial();

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    yield const LoginLoading();
    if (event is LoginButtonPressed) {
      try {
        final token = await authRepository.authenticate(
          email: event.email,
          password: event.password,
        );
        print(token);
        // authenticationBloc.add(LoggedIn(token: token));
        yield const LoginInitial();
      } on DioException catch (err) {
        yield const LoginFailure(error: "err.message");
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
