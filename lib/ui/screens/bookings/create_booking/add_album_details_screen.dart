import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../bloc/sheet_bloc.dart';
import '../../../../bloc/user_bloc.dart';
import '../../../../model/sheet.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';
import '../../../widgets/navbar_button.dart';
import 'add_amount_details_screen.dart';

class AddAlbumDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> response;

  const AddAlbumDetailsScreen({super.key, required this.response});

  static Future open(
    BuildContext context, {
    required Map<String, dynamic> response,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddAlbumDetailsScreen(response: response),
      ),
    );
  }

  @override
  State<AddAlbumDetailsScreen> createState() => _AddAlbumDetailsScreenState();
}

class _AddAlbumDetailsScreenState extends State<AddAlbumDetailsScreen> {
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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    if (!(_formKey.currentState?.validate() ?? true)) return;
                    _formKey.currentState?.save();

                    bookingBloc.albumData.add(
                      {'sheet': sheet, 'quantity': quantityCtrl.text},
                    );
                    setState(() {});
                    reset();
                  },
                  child: const Text('Add more'),
                ),
              ),
              if (bookingBloc.albumData.isNotEmpty) ...[
                Text(
                  'Event Details Added',
                  style: textTheme.titleLarge!.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 10),
                for (Map<String, dynamic> i
                    in bookingBloc.albumData.toList()) ...[
                  CustomCard(
                    margin: EdgeInsets.zero,
                    radius: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: DetailsTile(
                                  title: const Text('Sheet'),
                                  value: Text('${i['sheet']}'),
                                ),
                              ),
                              Expanded(
                                child: DetailsTile(
                                  title: const Text('Quantity'),
                                  value: Text('${i['quantity']}'),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: -15,
                            right: -15,
                            child: IconButton(
                              onPressed: () async {
                                setState(() => bookingBloc.albumData.remove(i));
                              },
                              icon: Icon(
                                Icons.remove_circle,
                                color: Colors.redAccent.shade700,
                                size: 15,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ]
              ],
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: bookingBloc.albumData.isNotEmpty
            ? () async {
                var response = widget.response;
                print('OKnow${bookingBloc.albumData}');
                response['sheets'] = bookingBloc.albumData.toList();
                AddAmountDetailsScreen.open(context, response: response);
              }
            : null,
        child: const Text('Proceed'),
      ),
    );
  }
}
