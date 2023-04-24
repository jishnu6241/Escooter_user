import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/hub/hub_bloc.dart';
import 'custom_alert_dialog.dart';
import 'custom_card.dart';
import 'custom_progress_indicator.dart';
import 'custom_select_box.dart';

class HubSelector extends StatefulWidget {
  final Function(int) onSelect;
  final String label;
  const HubSelector({
    super.key,
    required this.onSelect,
    required this.label,
  });

  @override
  State<HubSelector> createState() => _HubSelectorState();
}

class _HubSelectorState extends State<HubSelector> {
  final HubBloc hubBlock = HubBloc();

  @override
  void initState() {
    hubBlock.add(GetAllHubEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocProvider<HubBloc>.value(
        value: hubBlock,
        child: BlocConsumer<HubBloc, HubState>(
          listener: (context, state) {
            if (state is HubFailureState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  title: 'Failed!',
                  message: state.message,
                  primaryButtonLabel: 'Retry',
                  primaryOnPressed: () {
                    hubBlock.add(GetAllHubEvent());
                    Navigator.pop(context);
                  },
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is HubSuccessState) {
              return CustomSelectBox(
                iconData: Icons.hub_outlined,
                items: List<CustomSelectBoxItem>.generate(
                  state.hubs.length,
                  (index) => CustomSelectBoxItem(
                    value: state.hubs[index]['id'],
                    label: state.hubs[index]['name'],
                  ),
                ),
                label: widget.label,
                onChange: (selected) {
                  widget.onSelect(selected != null ? selected.value : 0);
                },
              );
            } else if (state is HubFailureState) {
              return const SizedBox();
            } else {
              return const Center(
                child: CustomProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
