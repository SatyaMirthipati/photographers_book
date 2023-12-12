import 'package:flutter/material.dart';
import '../../../widgets/avatar.dart';

class ProfileAvatar extends StatelessWidget {
  final VoidCallback onTap;

  const ProfileAvatar({super.key, required this.onTap});

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
