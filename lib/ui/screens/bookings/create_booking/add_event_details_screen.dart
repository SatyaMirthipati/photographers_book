import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../model/category.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/details_tile.dart';
import '../../../widgets/error_snackbar.dart';
import '../../../widgets/navbar_button.dart';
import 'add_album_details_screen.dart';

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

  int textFieldCount = 1;

  final resourceCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  DateTime? dateTime;

  List<Category> videos = [];
  List<Category> drones = [];
  List<Category> cameras = [];
  List<Category> events = [];

  Category? event;
  Category? video;
  Category? camera;
  Category? drone;

  fetchCategories() async {
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    var data = await bookingBloc.getCategories();
    events = data.where((e) => e.category == 'EVENT').toList();
    cameras = data.where((e) => e.category == 'CAMERA').toList();
    videos = data.where((e) => e.category == 'VIDEO').toList();
    drones = data.where((e) => e.category == 'DRONE').toList();
    print('$events');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchCategories();
    print('basic ${widget.response}');
  }

  reset() {
    event = null;
    video = null;
    camera = null;
    drone = null;
    dateTime = null;
    dateCtrl.text = '';
    resourceCtrl.text = '';
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
                'Event Details',
                style: textTheme.titleLarge!.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 10),
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
                      child: Text(item.type ?? 'NA'),
                    )
                ],
              ),
              const SizedBox(height: 25),
              DatePicker(
                dateTime,
                dateCtrl: dateCtrl,
                startDate: DateTime.now(),
                labelText: 'Event Date',
                onDateChange: (dateTime) {
                  setState(() => this.dateTime = dateTime);
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: resourceCtrl,
                keyboardType: TextInputType.number,
                style: textTheme.bodyLarge,
                textInputAction: TextInputAction.done,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                  labelText: 'Video',
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
                      child: Text(item.type ?? 'NA'),
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
                  labelText: 'Camera',
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
                      child: Text(item.type ?? 'NA'),
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
                  labelText: 'Drone',
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
                      child: Text(item.type ?? 'NA'),
                    )
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    if (!(_formKey.currentState?.validate() ?? true)) return;
                    _formKey.currentState?.save();

                    if (dateTime == null) {
                      return ErrorSnackBar.show(
                        context,
                        'Please date to continue',
                      );
                    }
                    bookingBloc.eventsData.add(
                      {
                        'event': event?.type,
                        'video': video?.type,
                        'camera': camera?.type,
                        'drone': drone?.type,
                        'date': DateFormat('yyyy-MM-dd').format(dateTime!),
                        'resource': resourceCtrl.text,
                      },
                    );
                    setState(() {});
                    reset();
                  },
                  child: const Text('Add more'),
                ),
              ),
              const SizedBox(height: 20),
              if (bookingBloc.eventsData.isNotEmpty) ...[
                Text(
                  'Event Details Added',
                  style: textTheme.titleLarge!.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 10),
                for (Map<String, dynamic> i
                    in bookingBloc.eventsData.toList()) ...[
                  CustomCard(
                    margin: EdgeInsets.zero,
                    radius: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: DetailsTile(
                                      title: const Text('Event'),
                                      value: Text('${i['event']}'),
                                    ),
                                  ),
                                  Expanded(
                                    child: DetailsTile(
                                      title: const Text('Date'),
                                      value: Text('${i['date']}'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              DetailsTile(
                                title: const Text('No Of Resource'),
                                value: Text('${i['resource']}'),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: DetailsTile(
                                      title: const Text('Camera'),
                                      value: Text('${i['camera']}'),
                                    ),
                                  ),
                                  Expanded(
                                    child: DetailsTile(
                                      title: const Text('Drone'),
                                      value: Text('${i['drone']}'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              DetailsTile(
                                title: const Text('Video'),
                                value: Text('${i['video']}'),
                              ),
                            ],
                          ),
                          Positioned(
                            top: -15,
                            right: -15,
                            child: IconButton(
                              onPressed: () async {
                                setState(
                                    () => bookingBloc.eventsData.remove(i));
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
        onPressed: () async {
          var response = widget.response;

          response['events'] = bookingBloc.eventsData.toList();

          AddAlbumDetailsScreen.open(context, response: response);
        },
        child: const Text('Proceed'),
      ),
    );
  }
}
