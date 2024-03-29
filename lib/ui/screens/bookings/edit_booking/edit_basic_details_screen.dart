import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../model/booking.dart';
import '../../../../model/category.dart';
import '../../../../utils/helper.dart';
import '../../../widgets/error_snackbar.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/navbar_button.dart';
import 'edit_events_screen.dart';

class EditBasicDetailsScreen extends StatelessWidget {
  final String id;

  const EditBasicDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    return FutureBuilder<Booking>(
      future: bookingBloc.getOneBooking(id: id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomErrorWidget.scaffold(error: snapshot.error);
        }
        if (!snapshot.hasData) return const LoadingWidget.scaffold();
        var booking = snapshot.data!;
        bookingBloc.updateEventsData = booking.events ?? [];
        bookingBloc.updateSheetsData = booking.sheets ?? [];
        return EditBasicDetailsBody(id: id, booking: booking);
      },
    );
  }
}

class EditBasicDetailsBody extends StatefulWidget {
  final String id;
  final Booking booking;

  const EditBasicDetailsBody({
    super.key,
    required this.id,
    required this.booking,
  });

  @override
  State<EditBasicDetailsBody> createState() => _EditBasicDetailsBodyState();
}

class _EditBasicDetailsBodyState extends State<EditBasicDetailsBody> {
  final formKey = GlobalKey<FormState>();

  final nameCtrl = TextEditingController();
  final mobileCtrl = TextEditingController();
  final addressCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.booking.name ?? '';
    mobileCtrl.text = widget.booking.mobile ?? '';
    addressCtrl.text = widget.booking.address ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        bookingBloc.updateEventsData.clear();
        bookingBloc.updateSheetsData.clear();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Edit Booking')),
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

            print(basicDetails);

            List<Category> data = await bookingBloc.getCategories();

            if (mounted) {
              EditEventsScreen.open(
                context,
                response: basicDetails,
                categories: data,
              );
            }
          },
          child: const Text('Proceed'),
        ),
      ),
    );
  }
}
