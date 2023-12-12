import 'package:flutter/material.dart';
import 'package:photographers_book/ui/widgets/avatar.dart';

class ProfileWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: null,
      child: const Avatar(
        size: 30,
        url: '',
        name: '',
        shape: BoxShape.circle,
        borderRadius: null,
      ),
    );
  }
}
