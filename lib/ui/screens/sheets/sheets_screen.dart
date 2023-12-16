import 'package:flutter/material.dart';
import 'package:photographers_book/ui/screens/sheets/widgets/sheet_card.dart';
import 'package:provider/provider.dart';

import '../../../bloc/sheet_bloc.dart';
import '../../../model/sheet.dart';
import '../../../resources/images.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/progress_button.dart';

class SheetsScreen extends StatelessWidget {
  const SheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var sheetBloc = Provider.of<SheetBloc>(context, listen: false);
    return Scaffold(
      body: FutureBuilder<List<Sheet>>(
        future: sheetBloc.getAllSheets(query: {'clientId': 10}),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return CustomErrorWidget(error: snapshot.error);
          }
          if (!snapshot.hasData) return const LoadingWidget();
          var list = snapshot.data ?? [];
          if (list.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Images.no_sheets, width: 150, height: 120),
                  const SizedBox(height: 40),
                  Text(
                    'There are no sheets added',
                    style: textTheme.titleMedium!.copyWith(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ProgressButton(
                    onPressed: () async {},
                    child: const Text('Add new sheet'),
                  )
                ],
              ),
            );
          }
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    return SheetCard(sheet: list[index]);
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
    );
  }
}
