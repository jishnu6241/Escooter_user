import 'package:escooter/blocs/hubs_and_scooters/hubs_and_scooters_bloc.dart';
import 'package:escooter/ui/widgets/custom_action_button.dart';
import 'package:escooter/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/util/value_validators.dart';
import 'package:flutter/material.dart';

class ScooterCard extends StatelessWidget {
  final dynamic scooterDetails;
  final dynamic hubDetails;
  final HubsAndScootersBloc hubsAndScootersBloc;
  const ScooterCard({
    super.key,
    required this.scooterDetails,
    required this.hubsAndScootersBloc,
    required this.hubDetails,
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
              scooterDetails['plate_no'].toString().toUpperCase(),
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
              onPressed: () async {
                int? key = await showDialog(
                  context: context,
                  builder: (context) => const PickScooterDialog(),
                );

                if (key != null) {
                  hubsAndScootersBloc.add(
                    StartRideEvent(
                      scooterId: scooterDetails['id'],
                      hubId: hubDetails['id'],
                      key: key,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              label: 'Pick This Scooter',
            ),
          ],
        ),
      ),
    );
  }
}

class PickScooterDialog extends StatefulWidget {
  const PickScooterDialog({
    super.key,
  });

  @override
  State<PickScooterDialog> createState() => _PickScooterDialogState();
}

class _PickScooterDialogState extends State<PickScooterDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Scooter Key',
      message: 'Enter the key you found on the scooter to continue.',
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          controller: textEditingController,
          validator: fiveDigitValidator,
          decoration: const InputDecoration(
            hintText: 'Enter Key',
          ),
        ),
      ),
      primaryButtonLabel: 'Continue',
      primaryOnPressed: () {
        if (formKey.currentState!.validate()) {
          Navigator.pop(context, int.parse(textEditingController.text.trim()));
        }
      },
    );
  }
}
