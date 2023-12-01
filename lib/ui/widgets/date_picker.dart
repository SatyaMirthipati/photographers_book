import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../resources/colors.dart';
import '../../../resources/images.dart';


class DatePicker extends StatelessWidget {
  DateTime? date;
  TextEditingController dateCtrl;
  final Function onDateChange;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? hintText;
  final String? labelText;
  final bool? filled;
  final bool validator;

  DatePicker(
    this.date, {
    Key? key,
    required this.dateCtrl,
    required this.onDateChange,
    this.startDate,
    this.endDate,
    this.hintText,
    this.filled,
    this.labelText,
    this.validator = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return TextFormField(
      readOnly: true,
      controller: dateCtrl,
      style: textTheme.titleMedium,
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        date = await showDatePicker(
          context: context,
          initialDate: startDate ?? date ?? DateTime.now(),
          firstDate: startDate ?? DateTime(1900),
          lastDate: endDate ?? DateTime(2100),
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
        dateCtrl.text =
            date != null ? DateFormat('dd MMMM, yyyy').format(date!) : '';
        onDateChange.call(date);
      },
      validator: validator != false
          ? (value) {
              if ((value == null || value.trim().isEmpty && value == '')) {
                return 'This field can\'t be empty';
              }
              return null;
            }
          : null,
      onSaved: (v) => dateCtrl.text = v!,
      autocorrect: true,
      decoration: InputDecoration(
        isDense: true,
        filled: filled ?? false,
        labelText: labelText,
        hintText: hintText ?? '',
        hintStyle: textTheme.titleMedium!.copyWith(
          color: Colors.black.withOpacity(0.5),
        ),
        suffixIcon: IconButton(
          onPressed: null,
          icon: Image.asset(Images.calendar, width: 18),
        ),
      ),
    );
  }
}
