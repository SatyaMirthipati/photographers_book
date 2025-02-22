import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:photographers_book/bloc/booking_bloc.dart';
import 'package:photographers_book/model/booking.dart';
import 'package:provider/provider.dart';

import '../../../../model/category.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/error_snackbar.dart';
import '../../../widgets/navbar_button.dart';
import '../widgets/select_type_dialog.dart';

class EditBookingEventScreen extends StatefulWidget {
  final BookingsEvent bookingsEvents;
  final int index;
  final List<Category> categories;

  const EditBookingEventScreen({
    super.key,
    required this.bookingsEvents,
    required this.categories,
    required this.index,
  });

  static Future open(
    BuildContext context, {
    required BookingsEvent bookingsEvents,
    required int index,
    required List<Category> categories,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditBookingEventScreen(
          bookingsEvents: bookingsEvents,
          index: index,
          categories: categories,
        ),
      ),
    );
  }

  @override
  State<EditBookingEventScreen> createState() => _EditBookingEventScreenState();
}

class _EditBookingEventScreenState extends State<EditBookingEventScreen> {
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

  String? event;
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
    event = widget.bookingsEvents.event;
    video = widget.bookingsEvents.video ?? [];
    drone = widget.bookingsEvents.drone ?? [];
    camera = widget.bookingsEvents.camera ?? [];
    addressCtrl.text = widget.bookingsEvents.address ?? 'NA';
    cameraCtrl.text = camera.join(', ');
    videoCtrl.text = video.join(', ');
    droneCtrl.text = drone.join(', ');
    dateTime = widget.bookingsEvents.date;
    if (dateTime != null) {
      dateCtrl.text = DateFormat('dd MMMM, yyyy').format(dateTime!);
    }
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
      appBar: AppBar(title: const Text('Edit A Booking Event')),
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
              DropdownButtonFormField<String>(
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
                items: [
                  for (var item in events)
                    DropdownMenuItem<String>(
                      value: item.type,
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
                validator: true,
                onDateChange: (dateTime) {
                  setState(() => this.dateTime = dateTime);
                },
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
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: () async {
          final navigator = Navigator.of(context);
          if (!(_formKey.currentState?.validate() ?? true)) return;
          _formKey.currentState?.save();

          if (dateTime == null) {
            return ErrorSnackBar.show(
              context,
              'Please date to continue',
            );
          }

          Map<String, dynamic> data = {
            'event': event ?? '',
            'video': video,
            'camera': camera,
            'drone': drone,
            'date': DateFormat('yyyy-MM-dd').format(dateTime!),
            'address': addressCtrl.text,
          };

          bookingBloc.updateEventsData[widget.index] =
              BookingsEvent.fromMap(data);

          print(bookingBloc.updateEventsData[widget.index]);
          setState(() {});
          reset();
          navigator.pop(true);
        },
        child: const Text('Proceed'),
      ),
    );
  }
}
