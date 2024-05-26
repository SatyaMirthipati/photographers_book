import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../bloc/event_bloc.dart';
import '../../../model/category.dart';
import '../../../model/event.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/navbar_button.dart';
import '../bookings/widgets/select_type_dialog.dart';

// class EditEventDetails extends StatelessWidget {
//   final String id;
//
//   const EditEventDetails({super.key, required this.id});
//
//   @override
//   Widget build(BuildContext context) {
//     var eventBloc = Provider.of<EventBloc>(context, listen: false);
//     return FutureBuilder<Event>(
//       future: eventBloc.getOneEvent(id: id),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return CustomErrorWidget.scaffold(error: snapshot.error);
//         }
//         if (!snapshot.hasData) return const LoadingWidget.scaffold();
//         var event = snapshot.data!;
//         return EditEventBody(id: id, event: event);
//       },
//     );
//   }
// }

class EditEventBody extends StatefulWidget {
  final Event event;
  final List<Category> categories;
  final String id;

  const EditEventBody({
    super.key,
    required this.event,
    required this.id,
    required this.categories,
  });

  static Future open(
    BuildContext context, {
    required Event event,
    required List<Category> categories,
    required String id,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditEventBody(
          id: id,
          event: event,
          categories: categories,
        ),
      ),
    );
  }

  @override
  State<EditEventBody> createState() => _EditEventBodyState();
}

class _EditEventBodyState extends State<EditEventBody> {
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

    event = widget.event.event;
    video = widget.event.video ?? [];
    drone = widget.event.drone ?? [];
    camera = widget.event.camera ?? [];
    addressCtrl.text = widget.event.address ?? 'NA';
    cameraCtrl.text = camera.join(', ');
    videoCtrl.text = video.join(', ');
    droneCtrl.text = drone.join(', ');
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
