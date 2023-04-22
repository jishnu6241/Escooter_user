import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/ui/widgets/label_with_text.dart';
import 'package:flutter/material.dart';

class RidesCard extends StatelessWidget {
  const RidesCard({
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
                        fontWeight: FontWeight.w400,
                      ),
                ),
                Text(
                  "On Ride",
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: LabelWithText(
                    label: 'Scooter',
                    text: 'KL 13 A 1234',
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'Rider',
                    text: 'John',
                  ),
                ),
              ],
            ),
            const Divider(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: LabelWithText(
                    label: 'Start Hub',
                    text: 'Kannur',
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'End Hub',
                    text: 'Payyannur',
                  ),
                ),
              ],
            ),
            const Divider(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: LabelWithText(
                    label: 'Start Time',
                    text: '12/12/2022 10:00 am',
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'End Time',
                    text: '01/01/2023 10:00 am',
                  ),
                ),
              ],
            ),
            const Divider(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Expanded(
                  child: LabelWithText(
                    label: 'Amount',
                    text: '₹200',
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'Payment Status',
                    text: 'Pending',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
