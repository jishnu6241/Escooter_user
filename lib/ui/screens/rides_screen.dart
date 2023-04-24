import 'dart:async';

import 'package:escooter/blocs/hubs_and_scooters/hubs_and_scooters_bloc.dart';
import 'package:escooter/ui/screens/hub_details_screen.dart';
import 'package:escooter/ui/widgets/custom_action_button.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/ui/widgets/custom_search.dart';
import 'package:escooter/ui/widgets/hub_card.dart';
import 'package:escooter/ui/widgets/hub_selector.dart';
import 'package:escooter/ui/widgets/label_with_text.dart';
import 'package:escooter/util/value_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
                          ? RideCard(
                              rideDetails: state.rideDetails,
                              hubsAndScootersBloc: hubsAndScootersBloc,
                            )
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

class RideCard extends StatefulWidget {
  final dynamic rideDetails;
  final HubsAndScootersBloc hubsAndScootersBloc;
  const RideCard({
    super.key,
    required this.rideDetails,
    required this.hubsAndScootersBloc,
  });

  @override
  State<RideCard> createState() => _RideCardState();
}

class _RideCardState extends State<RideCard> {
  final Razorpay _razorpay = Razorpay();
  int hubId = 0;

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await showDialog(
      context: context,
      builder: (context) => const CustomAlertDialog(
        title: 'Payment Success',
        message: 'Thank you for the payment. Reopen the page to see changes',
        primaryButtonLabel: 'Ok',
      ),
    );

    widget.hubsAndScootersBloc.add(
      EndRideEvent(
        rideId: widget.rideDetails['id'],
        hubId: hubId,
        amount: getAmount(),
      ),
    );
    //
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Logger().e(response.error);
    showDialog(
      context: context,
      builder: (context) => CustomAlertDialog(
        title: 'Payment Failed',
        message: response.message ?? 'Something went wrong, Please try again',
        primaryButtonLabel: 'Ok',
      ),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }

  String getElapsed() {
    Duration duration = DateTime.now()
        .difference(DateTime.parse(widget.rideDetails['start_time']).toLocal());

    return formatDuration(duration);
  }

  int getAmount() {
    Duration duration = DateTime.now()
        .difference(DateTime.parse(widget.rideDetails['start_time']).toLocal());

    return duration.inMinutes * 10;
  }

  String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final hoursString = hours == 1 ? 'h' : 'h';
    final minutesString = minutes == 1 ? 'm' : 'm';
    return '$hours$hoursString $minutes$minutesString';
  }

  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {});
    });

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void makePayment() async {
    // String orderId = await createOrder(widget.testDetails['total_price']);

    var options = {
      'key': 'rzp_test_j07YpjyCexi5xr',
      'amount': getAmount() * 100,
      'name': 'Donatoo',
      // 'order_id': orderId,
      'description': 'Ride Payment',
      'prefill': {
        'contact': '7788776677',
        'email': Supabase.instance.client.auth.currentUser!.email,
      }
    };
    Logger().w(options);
    _razorpay.open(options);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

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
                widget.rideDetails['scooter']['plate_no']
                    .toString()
                    .toUpperCase(),
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
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Uri uri = Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=${widget.rideDetails['start_hub']['latitude']},${widget.rideDetails['start_hub']['longitude']}');

                        await launchUrl(uri);
                      },
                      child: LabelWithText(
                        label: 'Picked Hub',
                        text: widget.rideDetails['start_hub']['name']
                            .toString()
                            .toUpperCase(),
                        labelColor: Colors.white60,
                        textColor: Colors.white70,
                      ),
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Picked On',
                      text: DateFormat('dd/MM/yyyy hh:mm a').format(
                          DateTime.parse(widget.rideDetails['start_time'])
                              .toLocal()),
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
                children: [
                  Expanded(
                    child: LabelWithText(
                      label: 'Time Elapsed',
                      text: getElapsed(),
                      labelColor: Colors.white60,
                      textColor: Colors.green,
                    ),
                  ),
                  Expanded(
                    child: LabelWithText(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      label: 'Fair',
                      text: getAmount().toString(),
                      labelColor: Colors.white60,
                      textColor: Colors.orange,
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
                      onPressed: () async {
                        String? reason = await showDialog(
                          context: context,
                          builder: (context) => const ReportScooterDialog(),
                        );

                        if (reason != null) {
                          widget.hubsAndScootersBloc.add(
                            ReportScooterEvent(
                              rideId: widget.rideDetails['id'],
                              complaint: reason,
                            ),
                          );
                        }
                      },
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => CustomAlertDialog(
                            title: 'Drop Scooter',
                            message:
                                'Select the hub youre dropping in to drop the scooter,',
                            content: HubSelector(
                              onSelect: (id) {
                                if (id != 0) {
                                  hubId = id;
                                  makePayment();
                                  Navigator.pop(context);
                                }
                              },
                              label: 'Select Hub',
                            ),
                          ),
                        );
                      },
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

class ReportScooterDialog extends StatefulWidget {
  const ReportScooterDialog({
    super.key,
  });

  @override
  State<ReportScooterDialog> createState() => _ReportScooterDialogState();
}

class _ReportScooterDialogState extends State<ReportScooterDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Report',
      message: 'Enter your complaint to report the scooter.',
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: TextFormField(
          controller: textEditingController,
          validator: alphabeticWithSpaceValidator,
          minLines: 3,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Enter Complaint',
          ),
        ),
      ),
      primaryButtonLabel: 'Continue',
      primaryOnPressed: () {
        if (formKey.currentState!.validate()) {
          Navigator.pop(context, textEditingController.text.trim());
        }
      },
    );
  }
}
