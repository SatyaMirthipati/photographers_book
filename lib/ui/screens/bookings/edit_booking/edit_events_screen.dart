import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:photographers_book/ui/screens/bookings/edit_booking/edit_booking_event_screen.dart';
import 'package:provider/provider.dart';

import '../../../../bloc/booking_bloc.dart';
import '../../../../model/category.dart';
import '../../../../resources/images.dart';
import '../../../widgets/custom_card.dart';
import '../../../widgets/details_tile.dart';
import '../../../widgets/error_snackbar.dart';
import '../../../widgets/navbar_button.dart';

class EditEventsScreen extends StatefulWidget {
  final Map<String, dynamic> response;
  final List<Category> categories;

  const EditEventsScreen({
    super.key,
    required this.response,
    required this.categories,
  });

  static Future open(
    BuildContext context, {
    required Map<String, dynamic> response,
    required List<Category> categories,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditEventsScreen(
          response: response,
          categories: categories,
        ),
      ),
    );
  }

  @override
  State<EditEventsScreen> createState() => _EditEventsScreenState();
}

class _EditEventsScreenState extends State<EditEventsScreen> {
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
      appBar: AppBar(title: const Text('Edit Booking')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (bookingBloc.updateEventsData.isNotEmpty) ...[
                Text(
                  'Event Details Added',
                  style: textTheme.titleLarge!.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 10),
                for (int i = 0;
                    i < bookingBloc.updateEventsData.toList().length;
                    i++) ...[
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
                                      value: Text(
                                        bookingBloc.updateEventsData[i].event ??
                                            'NA',
                                      ),
                                    ),
                                  ),
                                  if (bookingBloc.updateEventsData[i].date !=
                                      null) ...[
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: DetailsTile(
                                        title: const Text('Date'),
                                        value: Text(
                                            DateFormat('yyyy MMM, dd').format(
                                          bookingBloc.updateEventsData[i].date!,
                                        )),
                                      ),
                                    ),
                                  ],
                                  const SizedBox(width: 20),
                                ],
                              ),
                              const SizedBox(height: 15),
                              DetailsTile(
                                title: const Text('Address'),
                                value: Text(
                                  bookingBloc.updateEventsData[i].address ??
                                      'NA',
                                ),
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
                                          for (var item in bookingBloc
                                                  .updateEventsData[i].camera ??
                                              [])
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
                                          for (var item in bookingBloc
                                                  .updateEventsData[i].drone ??
                                              [])
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
                                    for (var item in bookingBloc
                                            .updateEventsData[i].video ??
                                        [])
                                      Text('${item ?? 'NA'},'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (i != 0)
                            Positioned(
                              top: -15,
                              right: -15,
                              child: IconButton(
                                onPressed: () async {
                                  setState(() {
                                    bookingBloc.updateEventsData.remove(
                                      bookingBloc.updateEventsData[i],
                                    );
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_circle,
                                  color: Colors.redAccent.shade700,
                                  size: 20,
                                ),
                              ),
                            ),
                          Positioned(
                            top: i != 0 ? 15 : -15,
                            right: -15,
                            child: IconButton(
                              onPressed: () async {
                                EditBookingEventScreen.open(
                                  context,
                                  bookingsEvents:
                                      bookingBloc.updateEventsData[i],
                                  index: i,
                                  categories: widget.categories,
                                );
                              },
                              icon: Image.asset(
                                Images.edit,
                                width: 20,
                                height: 20,
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
              }
            : null,
        child: const Text('Proceed'),
      ),
    );
  }
}
