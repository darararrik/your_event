import 'package:flutter/material.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/core/utils/utils.dart';

class AgentCard extends StatelessWidget {
  final AgencyServiceDto dto;
  const AgentCard({
    super.key,
    required this.dto,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 20),
      decoration: const BoxDecoration(
          color: grey50, borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10), child: placeholder),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dto.agencyName,
                      maxLines: 1,
                      style: TextStyle(overflow: TextOverflow.clip),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          Text("4.0", style: theme.textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              favoriteIcon,
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            dto.serviceName,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            dto.price.toString(),
          ),
        ],
      ),
    );
  }
}
