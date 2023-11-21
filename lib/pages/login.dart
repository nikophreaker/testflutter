import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Login/bloc/login_event.dart';
import 'package:flutter_application_1/Pages/Login/bloc/login_state.dart';
import 'package:flutter_application_1/State/Auth/bloc/authentication_bloc.dart';
import 'package:flutter_application_1/State/Auth/repositories/auth_repository.dart';
import 'package:flutter_application_1/network/api_client.dart';
import 'package:flutter_application_1/pages/Login/bloc/login_bloc.dart';
import 'package:flutter_application_1/widget/reusable_button.dart';
import 'package:flutter_application_1/widget/reusable_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:developer' as developer;

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final apiClient = ApiClient();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Login Page',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              developer.log(state.toString(), name: 'my.app.category');
              if (state is LoginFailure) {
                print("1111");
                EasyLoading.showError(state.error);
              } else if (state is LoginLoading) {
                print("111122");
                EasyLoading.show(status: 'Mohon tunggu...');
              } else if (state is LoginInitial) {
                print("111122333");
                EasyLoading.showSuccess('Logged in');
              }
            },
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ReusableTextField(
                      textEditController: _emailController,
                      hintTextString: 'Enter Email',
                      inputType: InputType.Email,
                      enableBorder: true,
                      cornerRadius: 48.0,
                      maxLength: 24,
                    ),
                    ReusableTextField(
                      textEditController: _passwordController,
                      hintTextString: 'Enter Password',
                      inputType: InputType.Password,
                      enableBorder: true,
                      cornerRadius: 48.0,
                      maxLength: 16,
                      prefixIcon: Icon(Icons.lock,
                          color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // LoginButton(
                    //   onSubmit: onSubmit,
                    // ),
                    ReusableButton(
                      iconData: Icons.login,
                      buttonText: 'Login',
                      onTap: () {
                        BlocProvider.of<LoginBloc>(context).add(
                            LoginButtonPressed(
                                email: _emailController.text,
                                password: _passwordController.text));
                        // Response user = await apiClient.login(
                        //     _emailController.text, _passwordController.text);

                        // print(user);
                      },
                    ),
                    // Container(
                    //   margin: const EdgeInsets.all(16),
                    //   height: 45,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     color: const Color.fromARGB(255, 253, 188, 51),
                    //     borderRadius: BorderRadius.circular(36),
                    //   ),
                    //   alignment: Alignment.center,
                    //   child: const Text(
                    //     'Login',
                    //     style: TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 20.0,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
          // body: Container(
          //   color: Colors.white,
          //   child: SingleChildScrollView(
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         ReusableTextField(
          //           textEditController: _emailController,
          //           hintTextString: 'Enter Email',
          //           inputType: InputType.Email,
          //           enableBorder: true,
          //           cornerRadius: 48.0,
          //           maxLength: 24,
          //         ),
          //         ReusableTextField(
          //           textEditController: _passwordController,
          //           hintTextString: 'Enter Password',
          //           inputType: InputType.Password,
          //           enableBorder: true,
          //           cornerRadius: 48.0,
          //           maxLength: 16,
          //           prefixIcon:
          //               Icon(Icons.lock, color: Theme.of(context).primaryColor),
          //         ),
          //         const SizedBox(
          //           height: 20,
          //         ),
          //         // LoginButton(
          //         //   onSubmit: onSubmit,
          //         // ),
          //         ReusableButton(
          //           iconData: Icons.login,
          //           buttonText: 'Login',
          //           onTap: () {
          //             BlocProvider.of<LoginBloc>(context).add(
          //                 LoginButtonPressed(
          //                     email: _emailController.text,
          //                     password: _passwordController.text));
          //             // Response user = await apiClient.login(
          //             //     _emailController.text, _passwordController.text);

          //             // print(user);
          //           },
          //         ),
          //         // Container(
          //         //   margin: const EdgeInsets.all(16),
          //         //   height: 45,
          //         //   width: double.infinity,
          //         //   decoration: BoxDecoration(
          //         //     color: const Color.fromARGB(255, 253, 188, 51),
          //         //     borderRadius: BorderRadius.circular(36),
          //         //   ),
          //         //   alignment: Alignment.center,
          //         //   child: const Text(
          //         //     'Login',
          //         //     style: TextStyle(
          //         //         color: Colors.black,
          //         //         fontSize: 20.0,
          //         //         fontWeight: FontWeight.bold),
          //         //   ),
          //         // )
          //       ],
          //     ),
          //   ),
          // ),
        ));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FocusScopeNode _focusScopeNode;

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
          email: _emailController.text, password: _passwordController.text));
    }
  }

  @override
  void initState() {
    _focusScopeNode = FocusScopeNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

  void _handleSubmitted(_) {
    _focusScopeNode.nextFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: FocusScope(
                node: _focusScopeNode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ReusableTextField(
                      textEditController: _emailController,
                      hintTextString: 'Enter Email',
                      inputType: InputType.Email,
                      enableBorder: true,
                      cornerRadius: 48.0,
                      maxLength: 24,
                    ),
                    ReusableTextField(
                      textEditController: _passwordController,
                      hintTextString: 'Enter Password',
                      inputType: InputType.Password,
                      enableBorder: true,
                      cornerRadius: 48.0,
                      maxLength: 16,
                      prefixIcon: Icon(Icons.lock,
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: LoginButton(
                onSubmit: onSubmit,
              ),
            )
          ],
        ));
  }
}

class LoginButton extends StatelessWidget {
  final Function onSubmit;

  const LoginButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: ReusableButton(
        iconData: Icons.login,
        buttonText: 'Login',
      ),
    );
  }
}
