import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../bloc/sheet_bloc.dart';
import '../../../../bloc/user_bloc.dart';
import '../../../../model/booking.dart';
import '../../../../model/sheet.dart';
import '../../../widgets/navbar_button.dart';

class AddAlbumEditBookingScreen extends StatefulWidget {
  const AddAlbumEditBookingScreen({super.key});

  static Future open(BuildContext context) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddAlbumEditBookingScreen(),
      ),
    );
  }

  @override
  State<AddAlbumEditBookingScreen> createState() =>
      _AddAlbumEditBookingScreenState();
}

class _AddAlbumEditBookingScreenState extends State<AddAlbumEditBookingScreen> {
  final _formKey = GlobalKey<FormState>();

  final quantityCtrl = TextEditingController();

  List<Sheet> sheets = [];
  String? sheet;

  reset() {
    sheet = null;
    quantityCtrl.text = '';
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    var sheetBloc = Provider.of<SheetBloc>(context, listen: false);
    sheets = await sheetBloc.getAllSheets(
      query: {'userId': userBloc.profile.id},
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Add Booking')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Album Details',
                style: textTheme.titleLarge!.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: sheet,
                style: textTheme.bodyLarge,
                isDense: true,
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: 'Album Type',
                  hintStyle: textTheme.titleMedium!.copyWith(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                icon: const Icon(Icons.arrow_drop_down, size: 16),
                onChanged: (value) {
                  setState(() => sheet = value);
                },
                onSaved: (value) => sheet = value,
                validator: (value) {
                  if (value == null) {
                    return 'This field can\'t be empty';
                  }
                  return null;
                },
                items: [
                  for (var item in sheets)
                    DropdownMenuItem<String>(
                      value: item.type,
                      child: Text(item.type ?? 'NA'),
                    )
                ],
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: quantityCtrl,
                keyboardType: TextInputType.number,
                style: textTheme.bodyLarge,
                textInputAction: TextInputAction.done,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: const InputDecoration(labelText: 'Quantity'),
                validator: (text) {
                  if (text?.trim().isEmpty ?? true) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: () async {
          if (!(_formKey.currentState?.validate() ?? true)) return;
          _formKey.currentState?.save();
          final navigator = Navigator.of(context);

          bookingBloc.updateSheetsData.add(
            BookingsSheet.fromMap({
              'sheet': sheet,
              'quantity': quantityCtrl.text,
            }),
          );
          setState(() {});
          reset();
          navigator.pop(true);
        },
        child: const Text('Proceed'),
      ),
    );
  }
}
