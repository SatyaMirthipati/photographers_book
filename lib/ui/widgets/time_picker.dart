import 'package:flutter/material.dart';

import '../../resources/theme.dart';

class TimePicker extends StatelessWidget {
  final TextEditingController timeCtrl;
  final Function onTimeChange;
  String? hintText;
  String? labelText;
  TimeOfDay? time;

  TimePicker(
    this.time, {
    Key? key,
    required this.timeCtrl,
    required this.onTimeChange,
    this.hintText,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return TextFormField(
      readOnly: true,
      controller: timeCtrl,
      style: textTheme.titleMedium,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        time = await showTimePicker(
          context: context,
          initialTime: time ?? TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.dial,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                textTheme: AppTheme.theme.textTheme,
                colorScheme: AppTheme.theme.colorScheme,
              ),
              child: child!,
            );
          },
        );
        timeCtrl.text = (time == null ? '' : time?.format(context))!;
        onTimeChange(time);
      },
      validator: (value) {
        if (value == null) {
          return 'This field can\'t be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText ?? '',
        labelText: labelText ?? '',
        filled: false,
        suffixIcon: const Icon(
          Icons.access_time_rounded,
          color: Colors.black,
          size: 20,
        ),
      ),
    );
  }
}
