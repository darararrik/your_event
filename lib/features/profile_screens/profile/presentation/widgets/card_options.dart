// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class CardOptions extends StatelessWidget {
  final void Function() onTap;
  final String titleText;
  final Icon leading;
  const CardOptions({
    super.key,
    required this.onTap,
    required this.titleText,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      splashColor: Colors.transparent,
      onTap: onTap,
      leading: leading,
      title: Text(
        titleText,
        style: theme.textTheme.titleMedium,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
      ),
    );
  }
}
