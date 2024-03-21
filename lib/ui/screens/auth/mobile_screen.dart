import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../bloc/user_bloc.dart';
import '../../../config/routes.dart';
import '../../../resources/colors.dart';
import '../../../resources/images.dart';
import '../../widgets/error_snackbar.dart';
import 'widgets/resend_otp_button.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final usernameCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  bool otp = false;
  String? token;

  var border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: MyColors.border, width: 1),
  );
  var disabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Color(0x2024272C), width: 1),
  );

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 100),
          FractionallySizedBox(
            widthFactor: 0.55,
            child: Image.asset(Images.logo_main),
          ),
          const SizedBox(height: 20),
          Text(
            'Forgot Password',
            style: textTheme.headlineMedium!.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Don\'t worry! Please enter your mobile number',
            style: textTheme.labelSmall!.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          TextFormField(
            controller: usernameCtrl,
            style: textTheme.bodyLarge,
            textInputAction: TextInputAction.done,
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
          ),
          if (!otp)
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () async {
                  if (usernameCtrl.text.isEmpty || usernameCtrl.text == '') {
                    return ErrorSnackBar.show(
                      context,
                      'Please enter a valid email-id or mobile number',
                    );
                  }

                  var body = {'username': usernameCtrl.text};

                  var res = await userBloc.requestOtp(body: body);
                  if (res['userExists'] == false) {
                    if (mounted) {
                      return ErrorSnackBar.show(context, 'User doesn\'t exist');
                    }
                  } else {
                    token = res['access_token'];
                  }
                  setState(() => otp = true);
                },
                child: Text(
                  'Get Otp',
                  style: textTheme.bodyLarge!.copyWith(
                    color: MyColors.accentColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 25),
          TextFormField(
            cursorWidth: 1,
            controller: otpCtrl,
            style: textTheme.bodyLarge,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Enter OTP',
              border: otp == false ? disabledBorder : border,
              enabledBorder: otp == false ? disabledBorder : border,
              focusedBorder: otp == false ? disabledBorder : border,
            ),
            validator: (text) {
              if (text?.trim().isEmpty ?? true) {
                return 'This field cannot be empty';
              }
              return null;
            },
          ),
          if (otp)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Did not receive OTP ? ',
                  style: textTheme.labelSmall!.copyWith(fontSize: 13),
                ),
                Column(
                  children: [
                    const SizedBox(height: 2),
                    ResendOtpButton(
                      mobile: usernameCtrl.text,
                      onUpdate: (String token) => this.token = token,
                    ),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              try {
                final navigator = Navigator.of(context);

                var body = {'token': token, 'otp': otpCtrl.text};
                var res = await userBloc.verifyOtp(body: body);

                if (res['success'] == true) {
                  navigator.pushNamed(
                    '${Routes.resetPassword}/${res['access_token']}',
                  );
                } else {
                  if (mounted) ErrorSnackBar.show(context, 'Error occurred');
                }
              } on Exception catch (e) {
                if (mounted) ErrorSnackBar.show(context, e);
              }
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
