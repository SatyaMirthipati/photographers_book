import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../model/category.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/details_tile.dart';
import '../../../widgets/error_snackbar.dart';
import '../../../widgets/navbar_button.dart';
import '../widgets/select_type_dialog.dart';
import 'add_album_details_screen.dart';

class AddEventDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> response;
  final List<Category> categories;

  const AddEventDetailsScreen(
      {super.key, required this.response, required this.categories});

  static Future open(
    BuildContext context, {
    required Map<String, dynamic> response,
    required List<Category> categories,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddEventDetailsScreen(
          response: response,
          categories: categories,
        ),
      ),
    );
  }

  @override
  State<AddEventDetailsScreen> createState() => _AddEventDetailsScreenState();
}

class _AddEventDetailsScreenState extends State<AddEventDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  int textFieldCount = 1;

  final addressCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  final videoCtrl = TextEditingController();
  final cameraCtrl = TextEditingController();
  final droneCtrl = TextEditingController();
  DateTime? dateTime;

  List<Category> videosData = [];
  List<Category> dronesData = [];
  List<Category> camerasData = [];
  List<Category> events = [];

  Category? event;
  List<String> video = [];
  List<String> camera = [];
  List<String> drone = [];

  @override
  void initState() {
    super.initState();
    events = widget.categories.where((e) => e.category == 'EVENT').toList();
    camerasData =
        widget.categories.where((e) => e.category == 'CAMERA').toList();
    videosData = widget.categories.where((e) => e.category == 'VIDEO').toList();
    dronesData = widget.categories.where((e) => e.category == 'DRONE').toList();
    print('basic ${widget.response}');
  }

  reset() {
    event = null;
    video.clear();
    camera.clear();
    drone.clear();
    dateTime = null;
    dateCtrl.text = '';
    addressCtrl.text = '';
    cameraCtrl.text = '';
    droneCtrl.text = '';
    videoCtrl.text = '';
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
                validator: true,
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: addressCtrl,
                maxLines: 4,
                keyboardType: TextInputType.text,
                style: textTheme.bodyLarge,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Address'),
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
              TextFormField(
                readOnly: true,
                maxLines: null,
                controller: cameraCtrl,
                style: textTheme.bodyLarge,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Select Camera'),
                onTap: () async {
                  camera = await SelectTypeDialog.open(
                        context,
                        title: 'Select Camera Types',
                        types: camerasData,
                        selectedTypes: camera,
                      ) ??
                      [];
                  cameraCtrl.text = camera.join(', ');
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                readOnly: true,
                maxLines: null,
                controller: videoCtrl,
                style: textTheme.bodyLarge,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Select Video'),
                onTap: () async {
                  video = await SelectTypeDialog.open(
                        context,
                        title: 'Select Video Types',
                        types: videosData,
                        selectedTypes: video,
                      ) ??
                      [];
                  videoCtrl.text = video.join(', ');
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                readOnly: true,
                maxLines: null,
                controller: droneCtrl,
                style: textTheme.bodyLarge,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Select Drone'),
                onTap: () async {
                  drone = await SelectTypeDialog.open(
                        context,
                        title: 'Select Drone Types',
                        types: dronesData,
                        selectedTypes: drone,
                      ) ??
                      [];
                  droneCtrl.text = drone.join(', ');
                },
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      reset();
                      setState(() {});
                    },
                    child: const Text('Clear'),
                  ),
                  const Spacer(),
                  TextButton(
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
                          'event': event?.type ?? '',
                          'video': video.map((v) => v).toList(),
                          'camera': camera.map((c) => c).toList(),
                          'drone': drone.map((d) => d).toList(),
                          'date': DateFormat('yyyy-MM-dd').format(dateTime!),
                          'address': addressCtrl.text ?? '',
                        },
                      );
                      setState(() {});
                      reset();
                    },
                    child: const Text('Add'),
                  ),
                ],
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
                                      value: Text('${i['event'] ?? 'NA'}'),
                                    ),
                                  ),
                                  Expanded(
                                    child: DetailsTile(
                                      title: const Text('Date'),
                                      value: Text('${i['date'] ?? 'NA'}'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              DetailsTile(
                                title: const Text('No Of Resource'),
                                value: Text('${i['resource'] ?? 'NA'}'),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                children: [
                                  Expanded(
                                    child: DetailsTile(
                                      title: const Text('Camera'),
                                      value: Wrap(
                                        spacing: 5,
                                        runSpacing: 5,
                                        children: [
                                          for (var item in i['camera'])
                                            Text('${item ?? 'NA'},'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: DetailsTile(
                                      title: const Text('Drone'),
                                      value: Wrap(
                                        spacing: 5,
                                        runSpacing: 5,
                                        children: [
                                          for (var item in i['drone'])
                                            Text('${item ?? 'NA'},'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              DetailsTile(
                                title: const Text('Video'),
                                value: Wrap(
                                  spacing: 5,
                                  runSpacing: 5,
                                  children: [
                                    for (var item in i['video'])
                                      Text('${item ?? 'NA'},'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: -15,
                            right: -15,
                            child: IconButton(
                              onPressed: () async {
                                setState(() {
                                  bookingBloc.eventsData.remove(i);
                                });
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
        onPressed: bookingBloc.eventsData.isNotEmpty
            ? () async {
                if (event != null && dateTime != null) {
                  return ErrorSnackBar.show(
                    context,
                    'Please click on add button to add new event data',
                  );
                }

                var response = widget.response;
                response['events'] = bookingBloc.eventsData.toList();
                AddAlbumDetailsScreen.open(context, response: response);
              }
            : null,
        child: const Text('Proceed'),
      ),
    );
  }
}
