import 'package:flutter/material.dart';

class StatusProgressBar extends StatelessWidget {
  final int count;
  final int index;

  const StatusProgressBar({
    Key? key,
    required this.count,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var accentColor = Theme.of(context).colorScheme.secondary;
    return Row(
      children: [
        for (int i = 0; i < count; i++) ...[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: i > index
                  ? Border.all(color: accentColor.withOpacity(0.5), width: 2)
                  : null,
              color: i > index ? null : accentColor,
            ),
            padding: EdgeInsets.all(2),
            child: i > index
                ? CircleAvatar(
                    backgroundColor: accentColor.withOpacity(0.5),
                    radius: 6,
                  )
                : const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
          ),
          if (i != count - 1)
            Expanded(
              child: Container(
                height: 3,
                color: i < index ? accentColor : accentColor.withOpacity(0.5),
              ),
            ),
        ]
      ],
    );
  }
}
