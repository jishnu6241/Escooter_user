import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class HubCard extends StatelessWidget {
  final Function() onTap;
  const HubCard({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onPressed: onTap,
      color: Colors.greenAccent[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hub name',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Address line 1, address line 2, city, place, state ,district, pin 670301',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Available Scooters',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '20',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors.green[900],
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
