import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:photographers_book/ui/widgets/error_snackbar.dart';
import 'package:provider/provider.dart';

import '../../../bloc/booking_bloc.dart';
import '../../../config/routes.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/navbar_button.dart';
import '../../widgets/success_screen.dart';

class ReceivePaymentScreen extends StatefulWidget {
  final String id;
  final String amount;

  const ReceivePaymentScreen({
    super.key,
    required this.id,
    required this.amount,
  });

  @override
  State<ReceivePaymentScreen> createState() => _ReceivePaymentScreenState();
}

class _ReceivePaymentScreenState extends State<ReceivePaymentScreen> {
  final formKey = GlobalKey<FormState>();

  final paymentCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    double amount = double.parse(widget.amount);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Payment')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              children: [
                Text(
                  'Amount Details',
                  style: textTheme.titleLarge!.copyWith(fontSize: 16),
                ),
                const Spacer(),
                Text.rich(
                  TextSpan(
                    text: 'Payable Amount: ',
                    style: textTheme.titleSmall,
                    children: [
                      TextSpan(
                        text: widget.amount,
                        style: textTheme.bodyLarge,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: paymentCtrl,
              keyboardType: TextInputType.number,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(labelText: 'Payment'),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            DatePicker(
              dateTime,
              dateCtrl: dateCtrl,
              // startDate: DateTime.now(),
              labelText: 'Payment Date',
              onDateChange: (dateTime) {
                setState(() => this.dateTime = dateTime);
              },
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: amount > 1
            ? () async {
                final navigator = Navigator.of(context);
                var bookingBloc =
                    Provider.of<BookingBloc>(context, listen: false);

                if (!(formKey.currentState?.validate() ?? true)) return;
                formKey.currentState?.save();

                var pay = double.parse(paymentCtrl.text);
                if (amount < pay) {
                  return ErrorSnackBar.show(
                    context,
                    'The amount should not exceed $amount',
                  );
                }

                Map<String, dynamic> body = {
                  'bookingId': widget.id,
                  'amount': paymentCtrl.text,
                  'date': DateFormat('yyyy-MM-dd').format(dateTime!),
                };
                await bookingBloc.makePayment(body: body);
                if (mounted) {
                  SuccessScreen.open(
                    context,
                    text: 'Payment done successfully',
                    onProcess: () {
                      navigator.pushNamedAndRemoveUntil(
                        Routes.main,
                        (route) => false,
                      );
                    },
                  );
                }
              }
            : null,
        child: const Text('Submit'),
      ),
    );
  }
}
