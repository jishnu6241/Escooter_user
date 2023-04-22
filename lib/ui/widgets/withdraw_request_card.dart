import 'package:escooter/ui/widgets/custom_action_button.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/ui/widgets/label_with_text.dart';
import 'package:flutter/material.dart';

class WithdrawRequestCard extends StatelessWidget {
  const WithdrawRequestCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  "Pending",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const Divider(
              height: 10,
            ),
            Text(
              "#13",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 3,
            ),
            Row(
              children: const [
                Expanded(
                  child: LabelWithText(
                    label: 'Name',
                    text: 'John',
                  ),
                ),
                Expanded(
                  child: LabelWithText(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    label: 'Phone',
                    text: '9876543210',
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '₹500',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Divider(
              height: 30,
            ),
            CustomActionButton(
              iconData: Icons.done_all_outlined,
              label: 'Payment Done',
              color: Colors.blue[700]!,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
