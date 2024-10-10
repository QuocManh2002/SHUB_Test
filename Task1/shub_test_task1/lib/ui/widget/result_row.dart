import 'package:flutter/material.dart';

class ResultRow extends StatelessWidget {
  const ResultRow({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            overflow: TextOverflow.clip,
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
