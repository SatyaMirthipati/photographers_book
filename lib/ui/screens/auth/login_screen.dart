import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photographers_book/bloc/user_bloc.dart';
import 'package:provider/provider.dart';

import '../../../config/routes.dart';
import '../../../data/local/shared_prefs.dart';
import '../../../resources/colors.dart';
import '../../../resources/images.dart';
import '../../widgets/progress_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  final loginIdCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool showPassword = false;

  final _focusNode1 = FocusNode();

  @override
  void dispose() {
    _focusNode1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    return Scaffold(
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 100),
            FractionallySizedBox(
              widthFactor: 0.55,
              child: Image.asset(Images.logo_main),
            ),
            const SizedBox(height: 50),
            Text(
              'Login to your account',
              style: textTheme.headlineMedium!.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextFormField(
              cursorWidth: 1,
              controller: loginIdCtrl,
              style: textTheme.titleMedium,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your Mobile number or Email id',
              ),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onTapOutside: (v) {
                FocusScope.of(context).requestFocus(_focusNode1);
              },
              onFieldSubmitted: (v) async {
                FocusScope.of(context).requestFocus(_focusNode1);
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: passwordCtrl,
              focusNode: _focusNode1,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                  ),
                  onPressed: () => setState(() => showPassword = !showPassword),
                ),
              ),
              obscureText: !showPassword,
              keyboardType: TextInputType.visiblePassword,
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  Navigator.pushNamed(context, Routes.mobile);
                },
                child: Text(
                  'Forgot Password?',
                  style: textTheme.titleSmall!.copyWith(
                    color: MyColors.accentColor,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            ProgressButton(
              onPressed: () async {
                if (!(formKey.currentState?.validate() ?? true)) return;
                formKey.currentState?.save();
                final navigator = Navigator.of(context);

                Map<String, String> body = {
                  'username': loginIdCtrl.text.trim(),
                  'password': passwordCtrl.text.trim(),
                };
                var response = await userBloc.login(body: body);

                if (response['userExists'] == true) {
                  var token = response['access_token'];
                  await Prefs.setToken(token);
                  await userBloc.getProfile();
                  navigator.pushNamedAndRemoveUntil(
                    Routes.main,
                    (route) => false,
                  );
                } else {
                  navigator.pushNamedAndRemoveUntil(
                    Routes.register,
                    (route) => false,
                  );
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'New User? ',
                  style: textTheme.titleSmall,
                  children: [
                    TextSpan(
                      text: 'Create an account',
                      style: textTheme.titleMedium!.copyWith(
                        color: MyColors.accentColor,
                        fontSize: 13,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, Routes.register);
                        },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
