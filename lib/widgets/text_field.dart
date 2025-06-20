import 'package:flutter/material.dart';
import 'package:task_manager_client/core/local_storage.dart';

class FutureTextFieldValue extends StatelessWidget {
  final String storageKey;
  final String label;
  final TextStyle? style;
  final String fallback;

  const FutureTextFieldValue({
    super.key,
    required this.storageKey,
    this.label = '',
    this.style,
    this.fallback = '—',
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: LocalStorage.getData(storageKey),
      builder: (context, snapshot) {
        final text = (snapshot.connectionState == ConnectionState.waiting)
            ? 'unknown'
            : (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty)
                ? snapshot.data!
                : fallback;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (label.isNotEmpty) Text('$label: ', style: style ?? TextStyle(fontWeight: FontWeight.bold)),
            Flexible(child: Text(text, style: style)),
          ],
        );
      },
    );
  }
}