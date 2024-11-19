import 'package:flutter/material.dart';
import 'package:yourevent/core/utils/utils.dart';

class AgentCard extends StatelessWidget {
  const AgentCard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1), // Настройте цвет тени
              offset: Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 13,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 34,
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Agent name", style: theme.textTheme.bodyMedium),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          Text("4.0", style: theme.textTheme.bodyMedium)
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Омск",
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              chat,
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Название услуги",
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  "От 2000 руб.",
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
