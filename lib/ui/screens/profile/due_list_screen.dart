import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../bloc/booking_bloc.dart';
import '../../../model/due_list.dart';
import '../../../resources/images.dart';
import '../../widgets/details_tile.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';

class DueListScreen extends StatefulWidget {
  const DueListScreen({super.key});

  @override
  State<DueListScreen> createState() => _DueListScreenState();
}

class _DueListScreenState extends State<DueListScreen> {
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
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Due List')),
      body: ListView(
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
          StreamBuilder<String>(
            stream: searchStream,
            builder: (context, snapshot) {
              var search = snapshot.data ?? '';
              return FutureBuilder<List<DueList>>(
                future: bookingBloc.getDueList(query: {'search': search}),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return CustomErrorWidget(error: snapshot.error);
                  }
                  if (!snapshot.hasData) return const LoadingWidget();
                  var list = snapshot.data ?? [];
                  if (list.isEmpty) return const EmptyWidget();
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: list.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DetailsTile(
                              title: Text(
                                list[index].name ?? 'NA',
                                style: textTheme.titleMedium!.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              gap: 10,
                              value: Text(
                                list[index].mobile ?? 'NA',
                                style: textTheme.labelSmall,
                              ),
                            ),
                            const Spacer(),
                            DetailsTile(
                              title: Text(
                                '₹ ${list[index].due ?? '0'}/-',
                                style: textTheme.titleLarge!.copyWith(
                                  fontSize: 18,
                                ),
                              ),
                              gap: 10,
                              value: InkWell(
                                onTap: () {},
                                child: Image.asset(Images.phone, height: 15),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
