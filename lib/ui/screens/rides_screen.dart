import 'package:escooter/blocs/hubs_and_scooters/hubs_and_scooters_bloc.dart';
import 'package:escooter/ui/screens/hub_details_screen.dart';
import 'package:escooter/ui/widgets/custom_action_button.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/ui/widgets/custom_search.dart';
import 'package:escooter/ui/widgets/hub_card.dart';
import 'package:escooter/ui/widgets/label_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_alert_dialog.dart';
import '../widgets/custom_progress_indicator.dart';

class RidesScreen extends StatefulWidget {
  const RidesScreen({super.key});

  @override
  State<RidesScreen> createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  final HubsAndScootersBloc hubsAndScootersBloc = HubsAndScootersBloc();

  String? query;

  @override
  void initState() {
    super.initState();
    getHubsAndScooters();
  }

  void getHubsAndScooters() {
    hubsAndScootersBloc.add(GetAllHubsAndScootersEvent(query: query));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HubsAndScootersBloc>.value(
      value: hubsAndScootersBloc,
      child: BlocConsumer<HubsAndScootersBloc, HubsAndScootersState>(
        listener: (context, state) {
          if (state is HubsAndScootersFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Oops!',
                message: state.message,
                primaryButtonLabel: 'Ok',
                primaryOnPressed: () {
                  getHubsAndScooters();
                  Navigator.pop(context);
                },
              ),
            );
          }
        },
        builder: (context, state) {
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
                    onSearch: (search) {
                      query = search;
                      getHubsAndScooters();
                    },
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
                  state is HubsAndScootersSuccessState
                      ? state.rideDetails != null
                          ? RideCard()
                          : const Center(
                              child: Text(
                                'You dont have a ride!',
                              ),
                            )
                      : const SizedBox(),
                  const Divider(
                    height: 20,
                  ),
                  Expanded(
                    child: state is HubsAndScootersSuccessState
                        ? state.hubsAndScooters.isNotEmpty
                            ? ListView.separated(
                                itemBuilder: (context, index) => HubCard(
                                  hubDetails: state.hubsAndScooters[index],
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HubDetailsScreen(
                                          hubsAndScootersBloc:
                                              hubsAndScootersBloc,
                                          hubDetails:
                                              state.hubsAndScooters[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 10),
                                itemCount: state.hubsAndScooters.length,
                              )
                            : const Center(child: Text('No Hubs found'))
                        : const Center(child: CustomProgressIndicator()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
        },
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
