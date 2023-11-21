import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/network/api_client.dart';
import 'package:flutter_application_1/widget/reusable_button.dart';
import 'package:flutter_application_1/widget/reusable_text_field.dart';

class LoginPage extends StatelessWidget {
  final apiClient = ApiClient();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(36.0),
                // child: Image.asset(
                //   'assets/image/logo.png',
                //   fit: BoxFit.cover,
                //   width: double.infinity,
                // ),
              ),
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
                prefixIcon:
                    Icon(Icons.lock, color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              ReusableButton(
                iconData: Icons.login,
                buttonText: 'Login',
                onTap: () async {
                  Response user = await apiClient.login(
                      _emailController.text, _passwordController.text);

                  print(user);
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
    );
  }
}
