import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../resources/images.dart';
import '../../resources/theme.dart';

@immutable
class DatePicker extends StatelessWidget {
  final DateTime? date;
  final TextEditingController dateCtrl;
  final Function? onDateChange;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? hintText;
  final String? labelText;
  final bool? filled;
  final bool validator;

  const DatePicker(
    this.date, {
    Key? key,
    required this.dateCtrl,
    this.onDateChange,
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
      onTap: onDateChange != null
          ? () async {
              FocusScope.of(context).requestFocus(FocusNode());
              DateTime? dateNow = await showDatePicker(
                context: context,
                initialDate: startDate ?? date ?? DateTime.now(),
                firstDate: startDate ?? DateTime(1900),
                lastDate: endDate ?? DateTime(2100),
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
              dateCtrl.text = dateNow != null
                  ? DateFormat('dd MMMM, yyyy').format(dateNow)
                  : 'Select Date';
              onDateChange?.call(dateNow);
            }
          : null,
      onSaved: (v) => dateCtrl.text = v!,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText ?? '',
        suffixIcon: IconButton(
          onPressed: null,
          icon: Image.asset(Images.calendar, width: 18, height: 18),
        ),
      ),
      validator: validator == false
          ? null
          : (value) {
              if ((value == null || value.trim().isEmpty && value == '')) {
                return 'This field can\'t be empty';
              }
              return null;
            },
    );
  }
}
