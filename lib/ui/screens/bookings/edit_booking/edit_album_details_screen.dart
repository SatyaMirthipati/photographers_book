import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photographers_book/model/booking.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../bloc/sheet_bloc.dart';
import '../../../../bloc/user_bloc.dart';
import '../../../../model/sheet.dart';
import '../../../widgets/navbar_button.dart';

class EditAlbumDetailsScreen extends StatefulWidget {
  final BookingsSheet response;
  final int index;

  const EditAlbumDetailsScreen({
    super.key,
    required this.response,
    required this.index,
  });

  static Future open(
    BuildContext context, {
    required BookingsSheet response,
    required int index,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditAlbumDetailsScreen(
          response: response,
          index: index,
        ),
      ),
    );
  }

  @override
  State<EditAlbumDetailsScreen> createState() => _EditAlbumDetailsScreenState();
}

class _EditAlbumDetailsScreenState extends State<EditAlbumDetailsScreen> {
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
    print('Res000 ${widget.response}');
    sheet = widget.response.sheet;
    quantityCtrl.text = widget.response.quantity ?? 'NA';
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
      appBar: AppBar(title: const Text('Edit Booking')),
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
        onPressed: bookingBloc.updateSheetsData.isNotEmpty
            ? () async {
                final navigator = Navigator.of(context);
                if (!(_formKey.currentState?.validate() ?? true)) return;
                _formKey.currentState?.save();

                Map<String, dynamic> data = {
                  'sheet': sheet,
                  'quantity': quantityCtrl.text
                };
                bookingBloc.updateSheetsData[widget.index] =
                    BookingsSheet.fromMap(data);
                setState(() {});
                reset();
                navigator.pop(true);
              }
            : null,
        child: const Text('Proceed'),
      ),
    );
  }
}
