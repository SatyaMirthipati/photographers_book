import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photographers_book/ui/widgets/navbar_button.dart';
import 'package:provider/provider.dart';

import '../../../bloc/booking_bloc.dart';
import '../../../bloc/event_bloc.dart';
import '../../../model/category.dart';
import '../../../model/event.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';

class EditEventDetails extends StatelessWidget {
  final String id;

  const EditEventDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    var eventBloc = Provider.of<EventBloc>(context, listen: false);
    return FutureBuilder<Event>(
      future: eventBloc.getOneEvent(id: id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return CustomErrorWidget.scaffold(error: snapshot.error);
        }
        if (!snapshot.hasData) return const LoadingWidget.scaffold();
        var event = snapshot.data!;
        return EditEventBody(id: id, event: event);
      },
    );
  }
}

class EditEventBody extends StatefulWidget {
  final Event event;
  final String id;

  const EditEventBody({super.key, required this.event, required this.id});

  @override
  State<EditEventBody> createState() => _EditEventBodyState();
}

class _EditEventBodyState extends State<EditEventBody> {
  final _formKey = GlobalKey<FormState>();

  final addressCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  DateTime? dateTime;

  fetchCategories() async {
    var bookingBloc = Provider.of<BookingBloc>(context, listen: false);
    var data = await bookingBloc.getCategories();
    events = data.where((e) => e.category == 'EVENT').toList();
    cameras = data.where((e) => e.category == 'CAMERA').toList();
    videos = data.where((e) => e.category == 'VIDEO').toList();
    drones = data.where((e) => e.category == 'DRONE').toList();
    setState(() {});
  }

  List<Category> events = [];
  List<Category> videos = [];
  List<Category> cameras = [];
  List<Category> drones = [];
  String? event;
  List<String> video = [];
  List<String> camera = [];
  List<String> drone = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
    event = widget.event.event;
    video = widget.event.video ?? [];
    camera = widget.event.camera ?? [];
    drone = widget.event.drone ?? [];
    addressCtrl.text = widget.event.address ?? '';
    dateTime = widget.event.date;
    if (dateTime != null) {
      dateCtrl.text = DateFormat('dd MMMM, yyyy').format(dateTime!);
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Event')),
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
                validator: (value) {
                  if (value == null) {
                    return 'This field can\'t be empty';
                  }
                  return null;
                },
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
                onDateChange: (dateTime) {
                  setState(() => this.dateTime = dateTime);
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: addressCtrl,
                maxLines: 3,
                keyboardType: TextInputType.text,
                style: textTheme.bodyLarge,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Address'),
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
              // DropdownButtonFormField<String>(
              //   value: video,
              //   style: textTheme.bodyLarge,
              //   isDense: true,
              //   isExpanded: true,
              //   decoration: InputDecoration(
              //     labelText: 'Video',
              //     hintStyle: textTheme.titleMedium!.copyWith(
              //       color: Colors.black.withOpacity(0.5),
              //     ),
              //   ),
              //   icon: const Icon(Icons.arrow_drop_down, size: 16),
              //   onChanged: (value) {
              //     setState(() => video = value);
              //   },
              //   onSaved: (value) => video = value,
              //   validator: (value) {
              //     if (value == null) {
              //       return 'This field can\'t be empty';
              //     }
              //     return null;
              //   },
              //   items: [
              //     for (var item in videos)
              //       DropdownMenuItem<String>(
              //         value: item.type,
              //         child: Text(item.type ?? 'NA'),
              //       )
              //   ],
              // ),
              const SizedBox(height: 25),
              // DropdownButtonFormField<String>(
              //   value: camera,
              //   style: textTheme.bodyLarge,
              //   isDense: true,
              //   isExpanded: true,
              //   decoration: InputDecoration(
              //     labelText: 'Camera',
              //     hintStyle: textTheme.titleMedium!.copyWith(
              //       color: Colors.black.withOpacity(0.5),
              //     ),
              //   ),
              //   icon: const Icon(Icons.arrow_drop_down, size: 16),
              //   onChanged: (value) {
              //     setState(() => camera = value);
              //   },
              //   onSaved: (value) => camera = value,
              //   validator: (value) {
              //     if (value == null) {
              //       return 'This field can\'t be empty';
              //     }
              //     return null;
              //   },
              //   items: [
              //     for (var item in cameras)
              //       DropdownMenuItem<String>(
              //         value: item.type,
              //         child: Text(item.type ?? 'NA'),
              //       )
              //   ],
              // ),
              const SizedBox(height: 25),
              // DropdownButtonFormField<String>(
              //   value: drone,
              //   style: textTheme.bodyLarge,
              //   isDense: true,
              //   isExpanded: true,
              //   decoration: InputDecoration(
              //     labelText: 'Drone',
              //     hintStyle: textTheme.titleMedium!.copyWith(
              //       color: Colors.black.withOpacity(0.5),
              //     ),
              //   ),
              //   icon: const Icon(Icons.arrow_drop_down, size: 16),
              //   onChanged: (value) {
              //     setState(() => drone = value);
              //   },
              //   onSaved: (value) => drone = value,
              //   validator: (value) {
              //     if (value == null) {
              //       return 'This field can\'t be empty';
              //     }
              //     return null;
              //   },
              //   items: [
              //     for (var item in drones)
              //       DropdownMenuItem<String>(
              //         value: item.type,
              //         child: Text(item.type ?? 'NA'),
              //       )
              //   ],
              // ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: NavbarButton(
        onPressed: () async {
          if (!(_formKey.currentState?.validate() ?? true)) return;
          _formKey.currentState?.save();
          final navigator = Navigator.of(context);

          var eventBloc = Provider.of<EventBloc>(context, listen: false);

          Map<String, dynamic> body = {
            'event': event,
            'date': DateFormat('yyyy-MM-dd').format(dateTime!),
            'video': video,
            'camera': camera,
            'drone': drone,
            'address': addressCtrl.text,
            'status': widget.event.status,
          };
          await eventBloc.updateEvent(id: widget.id, body: body);

          navigator.pop(true);
        },
        child: const Text('Submit'),
      ),
    );
  }
}
