import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class ScooterCard extends StatelessWidget {
  const ScooterCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "#11",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  "On Ride",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'KL 13 A 1234',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Parked Hub',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              'Kannur',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
