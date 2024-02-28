import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../model/category.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/navbar_button.dart';

class AddEventDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> response;

  const AddEventDetailsScreen({super.key, required this.response});

  static Future open(
    BuildContext context, {
    required Map<String, dynamic> response,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddEventDetailsScreen(response: response),
      ),
    );
  }

  @override
  State<AddEventDetailsScreen> createState() => _AddEventDetailsScreenState();
}

class _AddEventDetailsScreenState extends State<AddEventDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> eventsData = [];

  int textFieldCount = 1;

  List<TextEditingController> controllers = [];
  List<DateTime> dateTimes = [];

  Set<Category> videos = {};
  Set<Category> drones = {};
  Set<Category> cameras = {};
  Set<Category> events = {};

  Category? event;
  Category? video;
  Category? camera;
  Category? drone;

  fetchCategories() async {
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    var data = await bookingBloc.getCategories();
    events = data.where((e) => e.category == 'EVENT').toSet();
    cameras = data.where((e) => e.category == 'CAMERA').toSet();
    videos = data.where((e) => e.category == 'VIDEO').toSet();
    drones = data.where((e) => e.category == 'DRONE').toSet();
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    print('basic ${widget.response}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Booking')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                children: List.generate(
                  textFieldCount,
                  (index) {
                    eventsData.add(
                      {
                        'event': '',
                        'date': '',
                        'video': '',
                        'camera': '',
                        'drone': ''
                      },
                    );
                    return buildUI(index: index + 1);
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => setState(() => textFieldCount++),
                  child: const Text('Add More'),
                ),
              )
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: () async {
          _formKey.currentState?.save();
          eventsData.removeWhere(
            (e) =>
                e['event'] == '' &&
                e['date'] == '' &&
                e['video'] == '' &&
                e['camera'] == '' &&
                e['drone'] == '',
          );
          Navigator.pop(context);
        },
        child: const Text('Save Address'),
      ),
    );
  }

  Widget buildUI({required int index}) {
    var textTheme = Theme.of(context).textTheme;
    return Form(
      key: ValueKey('Key-$index'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField<Category>(
            value: event,
            style: textTheme.bodyLarge,
            isDense: true,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'Event',
              hintStyle: textTheme.titleMedium!.copyWith(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            icon: const Icon(Icons.arrow_drop_down, size: 16),
            onChanged: (value) {
              setState(() => event = value);
            },
            onSaved: (value) => event = value,
            validator: (value) {
              if (value == null) {
                return 'This field can\'t be empty';
              }
              return null;
            },
            items: [
              for (var item in events)
                DropdownMenuItem<Category>(
                  value: item,
                  child: Text(item.category ?? 'NA'),
                )
            ],
          ),
          const SizedBox(height: 25),
          DatePicker(
            dateTimes[index],
            dateCtrl: controllers[index],
            onDateChange: (v) {},
          ),
          const SizedBox(height: 25),
          TextFormField(
            keyboardType: TextInputType.text,
            style: textTheme.bodyLarge,
            textInputAction: TextInputAction.done,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
            ],
            decoration: const InputDecoration(labelText: 'No of Resources'),
            validator: (text) {
              if (text?.trim().isEmpty ?? true) {
                return 'This field cannot be empty';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          Text(
            'Requirements',
            style: textTheme.titleSmall!.copyWith(
              color: Colors.black.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 15),
          DropdownButtonFormField<Category>(
            value: video,
            style: textTheme.bodyLarge,
            isDense: true,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'Event',
              hintStyle: textTheme.titleMedium!.copyWith(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            icon: const Icon(Icons.arrow_drop_down, size: 16),
            onChanged: (value) {
              setState(() => video = value);
            },
            onSaved: (value) => video = value,
            validator: (value) {
              if (value == null) {
                return 'This field can\'t be empty';
              }
              return null;
            },
            items: [
              for (var item in videos)
                DropdownMenuItem<Category>(
                  value: item,
                  child: Text(item.category ?? 'NA'),
                )
            ],
          ),
          const SizedBox(height: 25),
          DropdownButtonFormField<Category>(
            value: camera,
            style: textTheme.bodyLarge,
            isDense: true,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'Event',
              hintStyle: textTheme.titleMedium!.copyWith(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            icon: const Icon(Icons.arrow_drop_down, size: 16),
            onChanged: (value) {
              setState(() => camera = value);
            },
            onSaved: (value) => camera = value,
            validator: (value) {
              if (value == null) {
                return 'This field can\'t be empty';
              }
              return null;
            },
            items: [
              for (var item in cameras)
                DropdownMenuItem<Category>(
                  value: item,
                  child: Text(item.category ?? 'NA'),
                )
            ],
          ),
          const SizedBox(height: 25),
          DropdownButtonFormField<Category>(
            value: drone,
            style: textTheme.bodyLarge,
            isDense: true,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'Event',
              hintStyle: textTheme.titleMedium!.copyWith(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            icon: const Icon(Icons.arrow_drop_down, size: 16),
            onChanged: (value) {
              setState(() => drone = value);
            },
            onSaved: (value) => drone = value,
            validator: (value) {
              if (value == null) {
                return 'This field can\'t be empty';
              }
              return null;
            },
            items: [
              for (var item in drones)
                DropdownMenuItem<Category>(
                  value: item,
                  child: Text(item.category ?? 'NA'),
                )
            ],
          ),
        ],
      ),
    );
  }
}
