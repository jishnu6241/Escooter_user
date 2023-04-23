import 'package:escooter/ui/widgets/custom_action_button.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:flutter/material.dart';

class ScooterCard extends StatelessWidget {
  const ScooterCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Column(
          children: [
            Text(
              'KL 13 A 1234',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Divider(
              height: 20,
              color: Colors.white,
            ),
            CustomActionButton(
              iconData: Icons.check_outlined,
              onPressed: () {},
              label: 'Pick This Scooter',
            ),
          ],
        ),
      ),
    );
  }
}
