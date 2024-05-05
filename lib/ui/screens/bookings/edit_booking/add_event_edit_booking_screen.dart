import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:photographers_book/model/booking.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../model/category.dart';
import '../../../widgets/date_picker.dart';
import '../../../widgets/error_snackbar.dart';
import '../../../widgets/navbar_button.dart';

class AddEventEditBookingScreen extends StatefulWidget {
  final List<Category> categories;

  const AddEventEditBookingScreen({super.key, required this.categories});

  static Future open(
    BuildContext context, {
    required List<Category> categories,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddEventEditBookingScreen(categories: categories),
      ),
    );
  }

  @override
  State<AddEventEditBookingScreen> createState() =>
      _AddEventEditBookingScreenState();
}

class _AddEventEditBookingScreenState extends State<AddEventEditBookingScreen> {
  final _formKey = GlobalKey<FormState>();

  late MultiSelectController<Category?> videoController;
  late MultiSelectController<Category?> cameraController;
  late MultiSelectController<Category?> droneController;

  int textFieldCount = 1;

  final addressCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  DateTime? dateTime;

  List<Category> videosData = [];
  List<Category> dronesData = [];
  List<Category> camerasData = [];
  List<Category> events = [];

  Category? event;
  Set<Category?> video = {};
  Set<Category?> camera = {};
  Set<Category?> drone = {};

  @override
  void initState() {
    super.initState();
    videoController = MultiSelectController();
    cameraController = MultiSelectController();
    droneController = MultiSelectController();
    events = widget.categories.where((e) => e.category == 'EVENT').toList();
    camerasData =
        widget.categories.where((e) => e.category == 'CAMERA').toList();
    videosData = widget.categories.where((e) => e.category == 'VIDEO').toList();
    dronesData = widget.categories.where((e) => e.category == 'DRONE').toList();
  }

  reset() {
    event = null;
    video.clear();
    camera.clear();
    drone.clear();
    dateTime = null;
    dateCtrl.text = '';
    addressCtrl.text = '';
    videoController.clearAllSelection();
    cameraController.clearAllSelection();
    droneController.clearAllSelection();
  }

  @override
  void dispose() {
    videoController.dispose();
    cameraController.dispose();
    droneController.dispose();
    super.dispose();
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
              MultiSelectDropDown(
                controller: videoController,
                onOptionSelected: (options) {
                  video = options.map((e) => e.value).toSet();
                },
                options: videosData.map((e) {
                  return ValueItem(label: '${e.type}', value: e);
                }).toList(),
                hint: 'Select videos',
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                optionTextStyle: textTheme.bodyLarge,
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),
              const SizedBox(height: 25),
              MultiSelectDropDown(
                controller: cameraController,
                onOptionSelected: (options) {
                  camera = options.map((e) => e.value).toSet();
                },
                options: camerasData.map((e) {
                  return ValueItem(label: '${e.type}', value: e);
                }).toList(),
                hint: 'Select cameras',
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                optionTextStyle: textTheme.bodyLarge,
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),
              const SizedBox(height: 25),
              MultiSelectDropDown(
                controller: droneController,
                onOptionSelected: (options) {
                  drone = options.map((e) => e.value).toSet();
                },
                options: dronesData.map((e) {
                  return ValueItem(label: '${e.type}', value: e);
                }).toList(),
                hint: 'Select drones',
                selectionType: SelectionType.multi,
                chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                optionTextStyle: textTheme.bodyLarge,
                selectedOptionIcon: const Icon(Icons.check_circle),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: () {
          if (!(_formKey.currentState?.validate() ?? true)) return;
          _formKey.currentState?.save();
          final navigator = Navigator.of(context);

          if (dateTime == null) {
            return ErrorSnackBar.show(
              context,
              'Please date to continue',
            );
          }

          bookingBloc.updateEventsData.add(
            BookingsEvent.fromMap({
              'event': event?.type ?? '',
              'video': video.map((v) => v?.type).toList(),
              'camera': camera.map((c) => c?.type).toList(),
              'drone': drone.map((d) => d?.type).toList(),
              'date': DateFormat('yyyy-MM-dd').format(dateTime!),
              'address': addressCtrl.text,
            }),
          );
          setState(() {});
          reset();
          navigator.pop(true);
        },
        child: const Text('Proceed'),
      ),
    );
  }
}
