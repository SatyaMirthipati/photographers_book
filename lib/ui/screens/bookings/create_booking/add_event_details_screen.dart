import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
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
    videoController.clearAllSelection();
    cameraController.clearAllSelection();
    droneController.clearAllSelection();
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
                        'event': event?.type ?? '',
                        'video': video.map((v) => v?.type).toList(),
                        'camera': camera.map((c) => c?.type).toList(),
                        'drone': drone.map((d) => d?.type).toList(),
                        'date': DateFormat('yyyy-MM-dd').format(dateTime!),
                        'address': addressCtrl.text,
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
                if (bookingBloc.eventsData.isEmpty) {
                  return ErrorSnackBar.show(
                    context,
                    'Please fill the above fields to proceed',
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
