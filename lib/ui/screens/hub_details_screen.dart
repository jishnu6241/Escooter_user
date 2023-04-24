import 'package:escooter/blocs/hubs_and_scooters/hubs_and_scooters_bloc.dart';
import 'package:escooter/ui/widgets/hub_card.dart';
import 'package:escooter/ui/widgets/scooter_card.dart';
import 'package:flutter/material.dart';

class HubDetailsScreen extends StatefulWidget {
  final dynamic hubDetails;
  final HubsAndScootersBloc hubsAndScootersBloc;
  const HubDetailsScreen({
    super.key,
    required this.hubDetails,
    required this.hubsAndScootersBloc,
  });

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
                hubDetails: widget.hubDetails,
                onTap: () {},
              ),
              const Divider(
                height: 30,
              ),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) => ScooterCard(
                    hubDetails: widget.hubDetails,
                    hubsAndScootersBloc: widget.hubsAndScootersBloc,
                    scooterDetails: widget.hubDetails['scooters'][index],
                  ),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  itemCount: widget.hubDetails['scooters'].length,
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
