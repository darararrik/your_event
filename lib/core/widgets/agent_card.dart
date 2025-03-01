import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/lib.dart';

class AgentCard extends StatelessWidget {
  final AgencyServiceDto service;

  const AgentCard({
    super.key,
    required this.service,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var currencyFormatter = NumberFormat.currency(locale: "ru_RU", symbol: "₽");

    return GestureDetector(
      onTap: () {
        context.router
            .push(ServiceDetailsRoute(service: service));
      },
      child: Container(
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
                      Text(service.agencyName,
                          maxLines: 1,
                          style: theme.textTheme.bodySmall!
                              .copyWith(overflow: TextOverflow.clip)),
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
              service.serviceName,
              style: theme.textTheme.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              currencyFormatter.format(service.price),
              style: theme.textTheme.bodySmall!.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
