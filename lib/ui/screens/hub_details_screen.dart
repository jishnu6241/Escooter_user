import 'package:escooter/ui/widgets/hub_card.dart';
import 'package:escooter/ui/widgets/scooter_card.dart';
import 'package:flutter/material.dart';

class HubDetailsScreen extends StatefulWidget {
  const HubDetailsScreen({super.key});

  @override
  State<HubDetailsScreen> createState() => _HubDetailsScreenState();
}

class _HubDetailsScreenState extends State<HubDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Hub',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.greenAccent,
                fontWeight: FontWeight.bold,
              ),
        ),
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.greenAccent,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              HubCard(
                onTap: () {},
              ),
              const Divider(
                height: 30,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    runSpacing: 10,
                    children: List<Widget>.generate(
                      10,
                      (index) => const ScooterCard(),
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
      ),
    );
  }
}
