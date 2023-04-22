import 'package:escooter/ui/widgets/custom_action_button.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/ui/widgets/label_with_text.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: SizedBox(
        width: 320,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '#12',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(
                height: 10,
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
              Row(
                children: const [
                  Expanded(
                    child: LabelWithText(
                      label: 'Bank',
                      text: 'SBI',
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'IFSC',
                      text: 'SEWQ122332',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelWithText(
                label: 'Account Number',
                text: '123343343321',
              ),
              const SizedBox(
                height: 10,
              ),
              const LabelWithText(
                label: 'Deposit',
                text: '₹500',
              ),
              const Divider(
                height: 30,
              ),
              CustomActionButton(
                iconData: Icons.arrow_outward_outlined,
                label: 'View Proof',
                color: Colors.purple[700]!,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
