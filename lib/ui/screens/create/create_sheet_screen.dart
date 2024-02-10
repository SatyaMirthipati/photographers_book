import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../bloc/sheet_bloc.dart';
import '../../../utils/helper.dart';
import '../../widgets/navbar_button.dart';

class CreateSheetScreen extends StatefulWidget {
  const CreateSheetScreen({super.key});

  @override
  State<CreateSheetScreen> createState() => _CreateSheetScreenState();
}

class _CreateSheetScreenState extends State<CreateSheetScreen> {
  final formKey = GlobalKey<FormState>();

  final typeCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var sheetBloc = Provider.of<SheetBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Create A Sheet')),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              cursorWidth: 1,
              controller: typeCtrl,
              style: textTheme.titleMedium,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: 'Sheet type'),
              inputFormatters: <TextInputFormatter>[
                CapitalizeEachWordFormatter(),
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
              ],
              validator: (text) {
                if (text?.trim().isEmpty ?? true) {
                  return 'This field cannot be empty';
                }
                return null;
              },
            ),
            const SizedBox(height: 25),
            TextFormField(
              cursorWidth: 1,
              controller: priceCtrl,
              style: textTheme.titleMedium,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
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

          var body = {'type': typeCtrl.text, 'price': priceCtrl.text};
          await sheetBloc.createSheet(body: body);
          navigator.pop(true);
        },
        child: const Text('Submit'),
      ),
    );
  }
}
