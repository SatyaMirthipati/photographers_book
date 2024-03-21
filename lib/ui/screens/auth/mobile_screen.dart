import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photographers_book/config/routes.dart';
import 'package:photographers_book/resources/colors.dart';
import 'package:photographers_book/ui/widgets/error_snackbar.dart';
import 'package:photographers_book/ui/widgets/progress_button.dart';

import '../../../resources/images.dart';
import 'widgets/resend_otp_button.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final mobileCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  bool otp = false;

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
                  if (mobileCtrl.text.isEmpty || mobileCtrl.text == '') {
                    return ErrorSnackBar.show(
                      context,
                      'Please enter a mobile number',
                    );
                  }
                  if (mobileCtrl.text.length != 10) {
                    return ErrorSnackBar.show(
                      context,
                      'Please enter a valid mobile number',
                    );
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
                    ResendOtpButton(mobile: mobileCtrl.text),
                  ],
                ),
              ],
            ),
          const SizedBox(height: 30),
          ProgressButton(
            onPressed: () async {
              Navigator.pushNamed(context, Routes.resetPassword);
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
