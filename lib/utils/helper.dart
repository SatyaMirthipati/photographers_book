import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  static final currency = NumberFormat("#,##0.00", "en_US");

  static void launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await canLaunchUrl(uri)) throw Exception('Could not launch $url');
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  static Future<void> launchCall({required String phone}) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phone);
    await launchUrl(launchUri);
  }

  static Future<void> launchSms({required String phone}) async {
    final Uri launchUri = Uri(scheme: 'sms', path: phone);
    await launchUrl(launchUri);
  }

  static launchEmail({required String userName}) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: 'kumaraswamy.coign@gmail.com',
      query: 'subject=$userName&body=',
    );
    await launchUrl(launchUri);
  }

  static int calculateAge({required DateTime dob}) {
    DateTime now = DateTime.now();
    int age = now.year - dob.year;

    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class CapitalizeEachWordFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.split(' ').map(
        (word) {
          if (word.isNotEmpty) {
            return '${word[0].toUpperCase()}${word.substring(1)}';
          } else {
            return '';
          }
        },
      ).join(' '),
      selection: newValue.selection,
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() {
    return length > 0
        ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}'
        : '';
  }

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension E on String {
  String lastChars(int n) => substring(length - n);
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(this);
  }
}
