import 'package:escooter/blocs/complaints/complaints_bloc.dart';
import 'package:escooter/ui/widgets/complaints/complaints_card.dart';
import 'package:escooter/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter/ui/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  ComplaintsBloc complaintsBloc = ComplaintsBloc();

  @override
  void initState() {
    complaintsBloc.add(GetAllComplaintEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComplaintsBloc>.value(
      value: complaintsBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Reports',
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
        body: BlocConsumer<ComplaintsBloc, ComplaintsState>(
          listener: (context, state) {
            if (state is ComplaintFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed',
                  message: state.message,
                  primaryButtonLabel: 'Ok',
                ),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: state is ComplaintSuccessState
                          ? state.complaints.isNotEmpty
                              ? SingleChildScrollView(
                                  child: Wrap(
                                    runSpacing: 20,
                                    children: List<Widget>.generate(
                                      state.complaints.length,
                                      (index) => ComplaintCard(
                                        complaints: state.complaints[index],
                                      ),
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text('No reports found'),
                                )
                          : state is ComplaintLoadingState
                              ? const Center(
                                  child: CustomProgressIndicator(),
                                )
                              : const SizedBox(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
