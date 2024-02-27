import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photographers_book/ui/widgets/progress_button.dart';

import '../../../resources/colors.dart';
import '../../../resources/images.dart';
import '../../../utils/helper.dart';
import '../../widgets/error_snackbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final studioCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final rePasswordCtrl = TextEditingController();
  bool showPassword = false;
  bool reShowPassword = false;

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
            const SizedBox(height: 30),
            Text(
              'Create a new account now',
              style: textTheme.headlineMedium!.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            TextFormField(
              controller: nameCtrl,
              keyboardType: TextInputType.text,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                CapitalizeEachWordFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Name',
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
              controller: mobileCtrl,
              keyboardType: TextInputType.number,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
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
              controller: studioCtrl,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              style: textTheme.bodyLarge,
              inputFormatters: <TextInputFormatter>[
                CapitalizeEachWordFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              decoration: const InputDecoration(
                labelText: 'Studio Name',
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
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp("[0-9@a-zA-Z.]")),
              ],
              decoration: const InputDecoration(
                labelText: 'Email Id',
              ),
              validator: (text) {
                if (!text!.isValidEmail()) {
                  return 'Please check the email you entered';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: addressCtrl,
              maxLines: 4,
              keyboardType: TextInputType.text,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Address',
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
              controller: newPassCtrl,
              textInputAction: TextInputAction.done,
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
            const SizedBox(height: 25),
            TextFormField(
              controller: rePasswordCtrl,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFFAFAFA),
                labelText: 'Re- Enter password',
                suffixIcon: IconButton(
                  icon: Icon(
                    reShowPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 20,
                  ),
                  onPressed: () =>
                      setState(() => reShowPassword = !reShowPassword),
                ),
              ),
              obscureText: !reShowPassword,
              keyboardType: TextInputType.visiblePassword,
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 40),
            ProgressButton(
              onPressed: () async {
                final navigator = Navigator.of(context);

                if (!(formKey.currentState?.validate() ?? true)) return;
                formKey.currentState?.save();

                if (mobileCtrl.text != '' && mobileCtrl.text.length != 10) {
                  return ErrorSnackBar.show(
                    context,
                    'Please enter valid mobile number',
                  );
                }
                if (newPassCtrl.text != rePasswordCtrl.text) {
                  return ErrorSnackBar.show(
                    context,
                    'Password you entered should be same in both fields',
                  );
                }
              },
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Already an existing user? ',
                  style: textTheme.titleSmall,
                  children: [
                    TextSpan(
                      text: 'Login to your account',
                      style: textTheme.titleMedium!.copyWith(
                        color: MyColors.accentColor,
                        fontSize: 13,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
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
