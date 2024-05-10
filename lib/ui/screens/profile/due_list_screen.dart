import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../bloc/booking_bloc.dart';
import '../../../bloc/user_bloc.dart';
import '../../../config/routes.dart';
import '../../../model/due_list.dart';
import '../../../resources/images.dart';
import '../../../utils/helper.dart';
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
    var userBloc = Provider.of<UserBloc>(context, listen: false);
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
                hintText: 'Search with name',
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
                future: bookingBloc.getDueList(
                  query: {
                    'search': search,
                    'userId': userBloc.profile.id,
                  },
                ),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return CustomErrorWidget(error: snapshot.error);
                  }
                  if (!snapshot.hasData) return const LoadingWidget();
                  var list = snapshot.data ?? [];
                  if (list.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 3 - 50,
                        ),
                        const EmptyWidget(
                          message: 'No due list to show',
                          size: 150,
                        ),
                      ],
                    );
                  }
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
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '${Routes.receivePayment}/${list[index].id}/${list[index].due}',
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    value: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Helper.launchSms(
                                              phone: '${list[index].mobile}',
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: Image.asset(
                                              Images.sms,
                                              height: 15,
                                              width: 15,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        InkWell(
                                          onTap: () {
                                            Helper.launchCall(
                                              phone: '${list[index].mobile}',
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(3),
                                            child: Image.asset(
                                              Images.phone,
                                              height: 15,
                                              width: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(double.maxFinite, 40),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '${Routes.receivePayment}/${list[index].id}/${list[index].due}',
                                  );
                                },
                                child: const Text('Receive Payment'),
                              )
                            ],
                          ),
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
