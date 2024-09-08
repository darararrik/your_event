import 'package:flutter/material.dart';

class ArticlesCard extends StatelessWidget {
  const ArticlesCard({super.key, required this.rhymes, required this.word});

  final String word;
  final List<String> rhymes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BaseConatiner(
      width: 200,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            word,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Flexible(
            child: Text(
              rhymes.asMap().entries.map((e) {
                final sb = StringBuffer();
                sb.write(e.value);
                if (e.key != rhymes.length - 1) {
                  sb.write(',  ');
                }
                return sb.toString();
              }).join(),
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 13,
                color: theme.hintColor.withOpacity(0.4),
              ),
              maxLines: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class BaseConatiner extends StatelessWidget {
  const BaseConatiner({
    super.key,
    required this.child,
    this.width,
    this.margin,
    this.padding = const EdgeInsets.only(left: 12),
  });

  final double? width;
  final EdgeInsets? margin;
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}