import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../config/routes.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/navbar_button.dart';
import '../../../widgets/success_screen.dart';

class AddAmountDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> response;

  const AddAmountDetailsScreen({super.key, required this.response});

  static Future open(
    BuildContext context, {
    required Map<String, dynamic> response,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddAmountDetailsScreen(response: response),
      ),
    );
  }

  @override
  State<AddAmountDetailsScreen> createState() => _AddAmountDetailsScreenState();
}

class _AddAmountDetailsScreenState extends State<AddAmountDetailsScreen> {
  final formKey = GlobalKey<FormState>();

  final eventAmountCtrl = TextEditingController();
  final extraAmountCtrl = TextEditingController();
  final totalAmountCtrl = TextEditingController();
  final advanceAmountCtrl = TextEditingController();
  final dueBalanceCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  final dateCtrl = TextEditingController();
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    print(widget.response);
    var textTheme = Theme.of(context).textTheme;
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Booking')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Basic Details',
              style: textTheme.titleLarge!.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: eventAmountCtrl,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(labelText: 'Event Amount'),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: extraAmountCtrl,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(labelText: 'Extra Amount'),
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: totalAmountCtrl,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(labelText: 'Total Amount'),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: advanceAmountCtrl,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              onChanged: (v) {
                if (advanceAmountCtrl.text != '') {
                  var total = int.parse(totalAmountCtrl.text);
                  var advance = int.parse(advanceAmountCtrl.text);
                  dueBalanceCtrl.text = '${total - advance}';
                } else {
                  dueBalanceCtrl.text = totalAmountCtrl.text;
                }
                setState(() {});
              },
              decoration: const InputDecoration(labelText: 'Advance'),
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
              startDate: DateTime.now(),
              labelText: 'Payment Date',
              onDateChange: (dateTime) {
                setState(() => this.dateTime = dateTime);
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              readOnly: true,
              controller: dueBalanceCtrl,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: const InputDecoration(labelText: 'Due balance'),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: descriptionCtrl,
              maxLines: 4,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.text,
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: () async {
          final navigator = Navigator.of(context);
          if (!(formKey.currentState?.validate() ?? true)) return;
          formKey.currentState?.save();

          Map<String, dynamic> bookingResponse = widget.response;

          bookingResponse['total'] = totalAmountCtrl.text;
          bookingResponse['extra'] = extraAmountCtrl.text;
          bookingResponse['payable'] = eventAmountCtrl.text;
          bookingResponse['paid'] = advanceAmountCtrl.text;
          bookingResponse['due'] = dueBalanceCtrl.text;
          bookingResponse['dueDate'] =
              DateFormat('yyyy-MM-dd').format(dateTime!);
          bookingResponse['status'] = true;
          await bookingBloc.createBooking(body: bookingResponse);
          SuccessScreen.open(
            context,
            text: 'Booking Added Successfully',
            onProcess: () {
              bookingBloc.albumData.clear();
              bookingBloc.eventsData.clear();
              navigator.pushNamedAndRemoveUntil(Routes.main, (route) => false);
            },
          );
        },
        child: const Text('Proceed'),
      ),
    );
  }
}
