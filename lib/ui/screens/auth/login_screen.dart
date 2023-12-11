import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../config/routes.dart';
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

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
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
                labelText: 'User Id',
              ),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: passwordCtrl,
              decoration: InputDecoration(
                labelText: 'Password',
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
                onPressed: () async {},
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
              onPressed: () async {},
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
