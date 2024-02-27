import 'package:flutter/material.dart';

import '../../../resources/colors.dart';

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
                textTheme: TextTheme(
                  titleLarge: textTheme.titleLarge,
                  titleMedium: textTheme.titleMedium,
                  titleSmall: textTheme.titleSmall,
                  bodyLarge: textTheme.bodyLarge!.copyWith(fontSize: 20),
                  bodyMedium: textTheme.bodyMedium,
                  bodySmall: textTheme.bodySmall,
                  labelLarge: textTheme.labelLarge,
                  labelSmall: textTheme.labelSmall,
                ),
                colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: MyColors.primaryColor,
                      secondary: MyColors.primaryColor,
                      onSecondary: Colors.white,
                      brightness: Brightness.light,
                      background: Colors.white,
                    ),
              ),
              child: child!,
            );
          },
        );
        timeCtrl.text = time == null
            ? ''
            : '${time?.hourOfPeriod.toString() ?? ''}:${time?.minute.toString() ?? ''} ${time?.period.name.toUpperCase() ?? ''}';

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
