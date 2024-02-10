import 'package:flutter/material.dart';
import 'package:photographers_book/bloc/user_bloc.dart';
import 'package:photographers_book/config/routes.dart';
import 'package:photographers_book/ui/widgets/error_snackbar.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../bloc/sheet_bloc.dart';
import '../../../model/sheet.dart';
import '../../../resources/images.dart';
import '../../widgets/dialog_confirm.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/progress_button.dart';
import 'widgets/sheet_card.dart';

class SheetsScreen extends StatefulWidget {
  const SheetsScreen({super.key});

  @override
  State<SheetsScreen> createState() => _SheetsScreenState();
}

class _SheetsScreenState extends State<SheetsScreen> {
  final searchSubject = BehaviorSubject<String>();
  final searchCtrl = TextEditingController();
  Stream<String>? searchStream;

  void onSearch(String value) {
    searchSubject.add(value);
  }

  @override
  void dispose() {
    searchSubject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    searchStream =
        searchSubject.debounceTime(const Duration(milliseconds: 100));
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    var sheetBloc = Provider.of<SheetBloc>(context, listen: false);
    return Scaffold(
      body: StreamBuilder<String>(
        stream: searchStream,
        builder: (context, snapshot) {
          var search = snapshot.data ?? '';
          return FutureBuilder<List<Sheet>>(
            future: sheetBloc.getAllSheets(
              query: {'userId': userBloc.profile.id, 'search': search},
            ),
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
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
                    child: TextFormField(
                      onChanged: onSearch,
                      decoration: const InputDecoration(
                        filled: false,
                        hintText: 'Search for sheet',
                        suffixIcon: Icon(
                          Icons.search,
                          size: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return SheetCard(
                        sheet: list[index],
                        onSelected: (item) async {
                          if (item == 'edit') {
                            var res = await Navigator.pushNamed(
                              context,
                              Routes.editSheet.setId('${list[index].id}'),
                            );
                            if (res != true) return;
                            setState(() {});
                          } else if (item == 'delete') {
                            var res = await ConfirmDialog.show(
                              context,
                              title: 'Delete Sheet ?',
                              message: 'Are you sure you want to delete sheet',
                            );
                            if (res != true) return;

                            var data = await sheetBloc.deleteSheet(
                              id: '${list[index].id}',
                            );
                            setState(() {});
                            return ErrorSnackBar.show(context, data['message']);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 100),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
