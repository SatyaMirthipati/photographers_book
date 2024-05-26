import 'package:flutter/material.dart';
import 'package:photographers_book/model/category.dart';

class SelectTypeDialog extends StatefulWidget {
  final String title;
  final List<Category> types;
  final List<String> selectedTypes;

  const SelectTypeDialog({
    super.key,
    required this.selectedTypes,
    required this.types,
    required this.title,
  });

  static Future<List<String>?> open(
    BuildContext context, {
    required String title,
    required List<Category> types,
    required List<String> selectedTypes,
  }) {
    return showDialog<List<String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          elevation: 5,
          content: SelectTypeDialog(
            title: title,
            types: types,
            selectedTypes: selectedTypes,
          ),
        );
      },
    );
  }

  @override
  State<SelectTypeDialog> createState() => _SelectTypeDialogState();
}

class _SelectTypeDialogState extends State<SelectTypeDialog> {
  List<String> selectedTypes = [];

  @override
  void initState() {
    super.initState();
    selectedTypes = widget.selectedTypes;
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    widget.title,
                    style: textTheme.titleMedium!.copyWith(fontSize: 16),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      setState(() => selectedTypes.clear());
                      Navigator.pop(context, selectedTypes);
                    },
                    child: Text(
                      'Clear',
                      style: textTheme.titleMedium!.copyWith(
                        color: Colors.black38,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8),
              for (var i in widget.types) ...[
                Row(
                  children: [
                    Checkbox(
                      value: selectedTypes.contains(i.type),
                      onChanged: (v) {
                        if (selectedTypes.contains(i.type)) {
                          selectedTypes.remove(i.type);
                        } else {
                          selectedTypes.add('${i.type}');
                        }
                        setState(() {});
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(i.type ?? '')
                  ],
                ),
              ],
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: selectedTypes.isNotEmpty
                      ? () => Navigator.pop(context, selectedTypes)
                      : null,
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
