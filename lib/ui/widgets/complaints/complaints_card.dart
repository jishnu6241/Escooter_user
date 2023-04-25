import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/ui/widgets/label_with_text.dart';
import 'package:escooter/util/get_date.dart';
import 'package:flutter/material.dart';

class ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaints;
  const ComplaintCard({
    super.key,
    required this.complaints,
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
                getDate(DateTime.parse(complaints['created_at'])),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const Divider(
                height: 30,
              ),
              Text(
                complaints['complaint'].toString(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const Divider(
                height: 30,
              ),
              LabelWithText(
                label: 'Plate number',
                text:
                    complaints['scooter']['plate_no'].toString().toUpperCase(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
