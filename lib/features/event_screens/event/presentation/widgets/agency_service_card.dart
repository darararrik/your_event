import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:yourevent/core/core.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/router/router.dart';

class AgencyServiceCard extends StatelessWidget {
  final String agencyName;
  final List<AgencyServiceDto> services;

  const AgencyServiceCard({
    super.key,
    required this.agencyName,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            agencyName,
            style: theme.textTheme.labelMedium!.copyWith(color: greyLabel),
          ),
          SizedBox(
            height: 12,
          ),
          ...services.map(
            (service) => GestureDetector(
              onTap: () =>
                  context.router.push(ServiceDetailsRoute(service: service)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Text(
                          service.serviceName,
                          style: theme.textTheme.titleMedium,
                          softWrap: true, // Позволяет тексту переноситься
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            service.price.toString(),
                            style: theme.textTheme.labelMedium!
                                .copyWith(color: greyLabel),
                          ),
                          Text(
                            "руб",
                            style: theme.textTheme.labelMedium!
                                .copyWith(color: greyLabel),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right,
                            color: greyLabel,
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
