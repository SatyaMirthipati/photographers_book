import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/user_bloc.dart';
import '../../../config/routes.dart';
import '../../../resources/images.dart';
import '../../widgets/error_snackbar.dart';
import '../../widgets/progress_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String token;

  const ResetPasswordScreen({super.key, required this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  final newPassCtrl = TextEditingController();
  final rePasswordCtrl = TextEditingController();
  bool showPassword = false;
  bool reShowPassword = false;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    var width = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 100),
          FractionallySizedBox(
            widthFactor: 0.55,
            child: Image.asset(Images.logo_main),
          ),
          const SizedBox(height: 20),
          Text(
            'Change Password',
            style: textTheme.headlineMedium!.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          Text(
            '',
            style: textTheme.titleSmall!.copyWith(fontSize: 13),
          ),
          const SizedBox(height: 4),
          TextFormField(
            controller: newPassCtrl,
            decoration: InputDecoration(
              labelText: 'New Password',
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
            decoration: InputDecoration(
              labelText: 'Confirm New Password',
              suffixIcon: IconButton(
                icon: Icon(
                  reShowPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 20,
                ),
                onPressed: () {
                  setState(() => reShowPassword = !reShowPassword);
                },
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

              if (newPassCtrl.text != rePasswordCtrl.text) {
                return ErrorSnackBar.show(
                  context,
                  'Password you entered should be same in both fields',
                );
              }

              var body = {'token': widget.token, 'password': newPassCtrl.text};
              await userBloc.passwordChange(body: body);

              navigator.pushNamedAndRemoveUntil(Routes.login, (route) => false);
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
