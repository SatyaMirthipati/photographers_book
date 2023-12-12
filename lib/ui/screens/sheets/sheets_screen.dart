import 'package:flutter/material.dart';
import 'package:photographers_book/resources/images.dart';
import 'package:photographers_book/ui/widgets/progress_button.dart';

class SheetsScreen extends StatelessWidget {
  const SheetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.no_sheets, width: 150, height: 120),
            const SizedBox(height: 40),
            Text(
              'There are no sheets added',
              style: textTheme.titleMedium!.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ProgressButton(
              onPressed: () async {},
              child: const Text('Add new sheet'),
            )
          ],
        ),
      ),
    );
  }
}
