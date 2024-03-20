import 'package:flutter/material.dart';
import 'package:photographers_book/bloc/user_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../bloc/event_bloc.dart';
import '../../../model/event.dart';
import '../../../resources/images.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';
import 'widgets/event_card.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
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
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    var eventBloc = Provider.of<EventBloc>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('My Events')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 5),
            child: TextFormField(
              onChanged: onSearch,
              decoration: const InputDecoration(
                filled: false,
                hintText: 'Search for event',
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
              return FutureBuilder<List<Event>>(
                future: eventBloc.getEvents(
                  query: {'search': search, 'userId': userBloc.profile.id},
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
                          image: Images.no_events,
                          message: 'There are no events to show',
                          size: 150,
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemBuilder: (context, index) {
                      return EventCard(
                        event: list[index],
                        onRefresh: () => setState(() {}),
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
