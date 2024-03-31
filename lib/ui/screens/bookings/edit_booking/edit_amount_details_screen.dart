import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../config/routes.dart';
import '../../../../model/booking.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/navbar_button.dart';
import '../../../widgets/success_screen.dart';

class EditAmountDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> response;
  final Booking booking;

  const EditAmountDetailsScreen({
    super.key,
    required this.response,
    required this.booking,
  });

  static Future open(
    BuildContext context, {
    required Map<String, dynamic> response,
    required Booking booking,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditAmountDetailsScreen(
          response: response,
          booking: booking,
        ),
      ),
    );
  }

  @override
  State<EditAmountDetailsScreen> createState() =>
      _EditAmountDetailsScreenState();
}

class _EditAmountDetailsScreenState extends State<EditAmountDetailsScreen> {
  final formKey = GlobalKey<FormState>();

  final totalAmountCtrl = TextEditingController();
  final discountAmountCtrl = TextEditingController();
  final payableAmountCtrl = TextEditingController();
  final advanceAmountCtrl = TextEditingController();
  final dueBalanceCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();

  final dateCtrl = TextEditingController();
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
    totalAmountCtrl.text = '${widget.booking.total ?? '0'}';
    discountAmountCtrl.text = '${widget.booking.discount ?? '0'}';
    payableAmountCtrl.text = '${widget.booking.payable ?? '0'}';
    dueBalanceCtrl.text = '${widget.booking.due ?? '0'}';
    advanceAmountCtrl.text = '${widget.booking.paid ?? '0'}';
    descriptionCtrl.text = widget.booking.description ?? 'NA';
    dateTime = widget.booking.dueDate;
    if (dateTime != null) {
      dateCtrl.text = DateFormat('dd MMMM, yyyy').format(dateTime!);
    } else {
      dateCtrl.text = 'NA';
    }
  }

  calculate() {
    payableAmountCtrl.text =
        '${((int.tryParse(totalAmountCtrl.text) ?? 0) - (int.tryParse(discountAmountCtrl.text) ?? 0))}';
    dueBalanceCtrl.text =
        '${(int.tryParse(payableAmountCtrl.text) ?? -0) - (int.tryParse(advanceAmountCtrl.text) ?? 0)}';
  }

  @override
  Widget build(BuildContext context) {
    print(widget.response);
    var textTheme = Theme.of(context).textTheme;
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Booking')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Amount Details',
              style: textTheme.titleLarge!.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: totalAmountCtrl,
                    style: textTheme.bodyLarge,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (v) => calculate(),
                    decoration:
                        const InputDecoration(labelText: 'Total Amount'),
                    validator: (text) {
                      if (text?.trim().isEmpty ?? true) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: discountAmountCtrl,
                    style: textTheme.bodyLarge,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (v) => calculate(),
                    decoration:
                        const InputDecoration(labelText: 'Discount Amount'),
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: advanceAmountCtrl,
                    style: textTheme.bodyLarge,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (v) => calculate(),
                    decoration: const InputDecoration(labelText: 'Advance'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: payableAmountCtrl,
                    style: textTheme.bodyLarge,
                    textInputAction: TextInputAction.done,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (v) => calculate(),
                    decoration:
                        const InputDecoration(labelText: 'Payable balance'),
                    validator: (text) {
                      if (text?.trim().isEmpty ?? true) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                  ),
                )
              ],
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: dueBalanceCtrl,
                    style: textTheme.bodyLarge,
                    textInputAction: TextInputAction.done,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (v) => calculate(),
                    decoration: const InputDecoration(labelText: 'Due balance'),
                    validator: (text) {
                      if (text?.trim().isEmpty ?? true) {
                        return 'This field cannot be empty';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: DatePicker(
                    dateTime,
                    dateCtrl: dateCtrl,
                    startDate: DateTime.now(),
                    labelText: 'Next Due Date',
                    validator: false,
                    onDateChange: (dateTime) {
                      setState(() => this.dateTime = dateTime);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: descriptionCtrl,
              maxLines: 4,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.text,
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
          bookingResponse['payable'] = payableAmountCtrl.text;
          bookingResponse['paid'] = advanceAmountCtrl.text;
          bookingResponse['due'] = dueBalanceCtrl.text;
          bookingResponse['status'] = true;

          if (dateTime != null) {
            bookingResponse['dueDate'] =
                DateFormat('yyyy-MM-dd').format(dateTime!);
          }

          await bookingBloc.editBooking(
            id: '${widget.booking.id}',
            body: bookingResponse,
          );

          if (mounted) {
            SuccessScreen.open(
              context,
              text: 'Booking Updated Successfully',
              onProcess: () {
                navigator.pushNamedAndRemoveUntil(
                  Routes.main,
                  (route) => false,
                );
              },
            );
          }
        },
        child: const Text('Proceed'),
      ),
    );
  }
}
