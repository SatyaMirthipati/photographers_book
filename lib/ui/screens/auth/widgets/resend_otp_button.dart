import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/user_bloc.dart';
import '../../../widgets/error_snackbar.dart';

class ResendOtpButton extends StatefulWidget {
  final String mobile;
  final ValueChanged<String> onUpdate;

  const ResendOtpButton({
    Key? key,
    required this.mobile,
    required this.onUpdate,
  }) : super(key: key);

  @override
  State<ResendOtpButton> createState() => _ResendOtpButtonState();
}

class _ResendOtpButtonState extends State<ResendOtpButton> {
  Timer? timer;
  int seconds = 0;
  int times = 0;

  void createTimer() {
    times++;
    seconds = 30;
    setState(() {});
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (seconds == 0) {
          timer.cancel();
        } else {
          seconds--;
        }
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    if (times > 2) {
      return const TextButton(
        onPressed: null,
        child: Text('Resend'),
      );
    }
    return TextButton(
      onPressed: seconds != 0
          ? null
          : () async {
              if (widget.mobile.isEmpty || widget.mobile == '') {
                return ErrorSnackBar.show(
                  context,
                  'Please enter a valid email-id or mobile number',
                );
              }

              var body = {'username': widget.mobile};

              var res = await userBloc.requestOtp(body: body);
              if (res['userExists'] == false) {
                if (mounted) {
                  return ErrorSnackBar.show(context, 'User doesn\'t exist');
                }
              } else {
                widget.onUpdate(res['access_token']);
              }

              ErrorSnackBar.show(
                context,
                'OTP sent to ${widget.mobile}',
              );
              createTimer();
            },
      child: Text(
        seconds != 0
            ? 'Resend 00:${seconds.toString().padLeft(2, '0')}'
            : 'Resend',
      ),
    );
  }
}
