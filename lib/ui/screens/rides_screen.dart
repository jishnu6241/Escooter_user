import 'package:escooter/ui/screens/hub_details_screen.dart';
import 'package:escooter/ui/widgets/custom_action_button.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/ui/widgets/custom_search.dart';
import 'package:escooter/ui/widgets/hub_card.dart';
import 'package:escooter/ui/widgets/label_with_text.dart';
import 'package:flutter/material.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomSearch(
              onSearch: (search) {},
            ),
            const Divider(
              height: 20,
            ),
            Text(
              'My Ride',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            const RideCard(),
            const Divider(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  runSpacing: 10,
                  children: List<Widget>.generate(
                    10,
                    (index) => HubCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HubDetailsScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class RideCard extends StatelessWidget {
  const RideCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40,
      child: CustomCard(
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            children: [
              Text(
                'KL 13 A 1234',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Divider(
                height: 20,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Expanded(
                    child: LabelWithText(
                      label: 'Picked Hub',
                      text: 'Kannur',
                      labelColor: Colors.white60,
                      textColor: Colors.white70,
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Picked On',
                      text: '12/12/2022 10:00 am',
                      labelColor: Colors.white60,
                      textColor: Colors.white70,
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
                      label: 'Droped Hub',
                      text: 'Payyanur',
                      labelColor: Colors.white60,
                      textColor: Colors.white70,
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Droped On',
                      text: '12/12/2022 08:00 pm',
                      labelColor: Colors.white60,
                      textColor: Colors.white70,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 20,
                color: Colors.grey,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomActionButton(
                      color: Colors.red,
                      iconData: Icons.report_outlined,
                      onPressed: () {},
                      label: 'Report',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: CustomActionButton(
                      color: Colors.blue,
                      iconData: Icons.pin_drop_outlined,
                      onPressed: () {},
                      label: 'Drop Scooter',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
