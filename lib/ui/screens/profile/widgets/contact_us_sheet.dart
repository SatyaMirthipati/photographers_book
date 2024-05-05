import 'package:flutter/material.dart';
import 'package:photographers_book/bloc/user_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../utils/helper.dart';

class ContactUsSheet extends StatefulWidget {
  const ContactUsSheet({super.key});

  static Future open(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return const ContactUsSheet();
      },
    );
  }

  @override
  State<ContactUsSheet> createState() => _ContactUsSheetState();
}

class _ContactUsSheetState extends State<ContactUsSheet> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var primaryColor = Theme.of(context).primaryColor;
    var userBloc = Provider.of<UserBloc>(context, listen: false);
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Contact Us', style: textTheme.titleLarge),
          ),
          const SizedBox(height: 10),
          ListTile(
            onTap: () {
              Helper.launchCall(phone: '9963867732');
            },
            title: const Text('Connect us via call'),
            trailing: Icon(Icons.call, color: primaryColor, size: 20),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Helper.launchEmail(
                userName: 'Client "${userBloc.profile.name?.trim()}\'s" App Query',
              );
            },
            title: const Text('Connect us via e-mail'),
            trailing: Icon(Icons.mail_outlined, color: primaryColor, size: 20),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
