import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../bloc/sheet_bloc.dart';
import '../../../model/sheet.dart';
import '../../../utils/helper.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/navbar_button.dart';

class EditSheetScreen extends StatelessWidget {
  final String id;

  const EditSheetScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var sheetBloc = Provider.of<SheetBloc>(context, listen: false);
    return FutureBuilder<Sheet>(
      future: sheetBloc.getOneSheet(id: id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomErrorWidget.scaffold(error: snapshot.error);
        }
        if (!snapshot.hasData) return const LoadingWidget.scaffold();
        var sheet = snapshot.data!;
        return EditSheetBody(id: id, sheet: sheet);
      },
    );
  }
}

class EditSheetBody extends StatefulWidget {
  final String id;
  final Sheet sheet;

  const EditSheetBody({super.key, required this.id, required this.sheet});

  @override
  State<EditSheetBody> createState() => _EditSheetBodyState();
}

class _EditSheetBodyState extends State<EditSheetBody> {
  final formKey = GlobalKey<FormState>();

  final typeCtrl = TextEditingController();
  final priceCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    typeCtrl.text = widget.sheet.type ?? '';
    priceCtrl.text = '${widget.sheet.price ?? ''}';
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var sheetBloc = Provider.of<SheetBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Edit A Sheet')),
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
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]'))
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
          await sheetBloc.updateSheet(id: widget.id, body: body);
          navigator.pop(true);
        },
        child: const Text('Submit'),
      ),
    );
  }
}
