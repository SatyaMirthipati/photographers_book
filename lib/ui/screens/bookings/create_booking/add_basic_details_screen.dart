import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

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
  final MultiSelectController<User> _controller = MultiSelectController();

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
            SizedBox(height: 25),
            MultiSelectDropDown<User>(
              controller: _controller,
              clearIcon: const Icon(Icons.reddit),
              onOptionSelected: (options) {},
              options: <ValueItem<User>>[
                ValueItem(
                    label: 'Option 1',
                    value: User(name: 'User 1', id: 1)),
                ValueItem(
                    label: 'Option 2',
                    value: User(name: 'User 2', id: 2)),
                ValueItem(
                    label: 'Option 3',
                    value: User(name: 'User 3', id: 3)),
                ValueItem(
                    label: 'Option 4',
                    value: User(name: 'User 4', id: 4)),
                ValueItem(
                    label: 'Option 5',
                    value: User(name: 'User 5', id: 5)),
              ],
              maxItems: 4,
              singleSelectItemStyle: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold),
              chipConfig: const ChipConfig(
                  wrapType: WrapType.wrap, backgroundColor: Colors.red),
              optionTextStyle: const TextStyle(fontSize: 16),
              selectedOptionIcon: const Icon(
                Icons.check_circle,
                color: Colors.pink,
              ),
              searchEnabled: true,
              dropdownBorderRadius: 10,
              dropdownBackgroundColor: Colors.white,
              selectedOptionBackgroundColor: Colors.orange,
              selectedOptionTextColor: Colors.blue,
              dropdownMargin: 2,
              onOptionRemoved: (index, option) {},
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

          AddEventDetailsScreen.open(context, response: basicDetails);
        },
        child: const Text('Proceed'),
      ),
    );
  }
}

class User {
  final String name;
  final int id;

  User({required this.name, required this.id});

  @override
  String toString() {
    return 'User(name: $name, id: $id)';
  }
}