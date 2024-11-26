import 'package:flutter/material.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';

class AgentCardWidget extends StatelessWidget {
  const AgentCardWidget({
    super.key,
    required this.service,
  });

  final AgencyServiceDto service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(children: [
      Text(
        service.agencyName,
        style: theme.textTheme.bodyMedium,
      ),
      SizedBox(
        width: 8,
      ),
      Row(
        children: [
          const Icon(
            Icons.star,
            size: 16,
            color: Colors.amber,
          ),
          Text("4.0", style: theme.textTheme.bodyMedium),
        ],
      ),
    ]);
  }
}
