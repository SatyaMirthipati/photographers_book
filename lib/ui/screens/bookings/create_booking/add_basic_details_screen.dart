import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photographers_book/bloc/booking_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../model/category.dart';
import '../../../../utils/helper.dart';
import '../../../widgets/error_snackbar.dart';
import '../../../widgets/navbar_button.dart';
import 'add_event_details_screen.dart';

class AddBasicDetailsScreen extends StatefulWidget {
  const AddBasicDetailsScreen({super.key});

  @override
  State<AddBasicDetailsScreen> createState() => _AddBasicDetailsScreenState();
}

class _AddBasicDetailsScreenState extends State<AddBasicDetailsScreen> {
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
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
              controller: nameCtrl,
              keyboardType: TextInputType.text,
              style: textTheme.bodyLarge,
              textInputAction: TextInputAction.done,
              inputFormatters: <TextInputFormatter>[
                CapitalizeEachWordFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              decoration: const InputDecoration(labelText: 'Name'),
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
              decoration: const InputDecoration(labelText: 'Mobile Number'),
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
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
              decoration: const InputDecoration(labelText: 'Address'),
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
          var bookingBloc = Provider.of<BookingBloc>(context, listen: false);

          if (!(formKey.currentState?.validate() ?? true)) return;
          formKey.currentState?.save();

          if (mobileCtrl.text != '' && mobileCtrl.text.length != 10) {
            return ErrorSnackBar.show(
              context,
              'Please enter valid mobile number',
            );
          }

          Map<String, dynamic> basicDetails = {
            'name': nameCtrl.text,
            'mobile': mobileCtrl.text,
            'address': addressCtrl.text,
          };

          List<Category> data = await bookingBloc.getCategories();

          AddEventDetailsScreen.open(
            context,
            response: basicDetails,
            categories: data,
          );
        },
        child: const Text('Proceed'),
      ),
    );
  }
}
