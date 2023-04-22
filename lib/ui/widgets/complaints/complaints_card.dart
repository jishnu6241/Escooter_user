import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/ui/widgets/label_with_text.dart';
import 'package:flutter/material.dart';

class ComplaintCard extends StatelessWidget {
  const ComplaintCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: Colors.red[50],
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '19/04/2023',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const Divider(
                height: 30,
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec et sapien eget sem ornare lacinia quis a sapien.',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const Divider(
                height: 30,
              ),
              const LabelWithText(
                label: 'Plate number',
                text: 'KL 13 A 1234',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
