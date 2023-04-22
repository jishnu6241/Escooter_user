// import 'package:escooter_admin/ui/widgets/custom_action_button.dart';
// import 'package:escooter_admin/ui/widgets/custom_alert_dialog.dart';
// import 'package:escooter_admin/ui/widgets/custom_button.dart';
// import 'package:escooter_admin/ui/widgets/custom_card.dart';
// import 'package:flutter/material.dart';

// class AddEditHubDialog extends StatefulWidget {
//   final Map<String, dynamic>? hubDetails;
//   const AddEditHubDialog({
//     super.key,
//     this.hubDetails,
//   });

//   @override
//   State<AddEditHubDialog> createState() => _AddEditHubDialogState();
// }

// class _AddEditHubDialogState extends State<AddEditHubDialog> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();

//   @override
//   void initState() {
//     if (widget.hubDetails != null) {
//       _nameController.text = widget.hubDetails!['name'];
//       _addressController.text = widget.hubDetails!['address'];
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomAlertDialog(
//       width: 500,
//       title: widget.hubDetails != null ? "Edit Hub" : "Add Hub",
//       message: widget.hubDetails != null
//           ? "Change the following details and save to apply them"
//           : "Enter the following details to add a hub",
//       content: Form(
//         key: _formKey,
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             Text(
//               'Hub Name',
//               style: Theme.of(context).textTheme.labelMedium?.copyWith(
//                     color: Colors.black45,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(height: 5),
//             CustomCard(
//               child: TextFormField(
//                 controller: _nameController,
//                 validator: (value) {
//                   if (value != null && value.trim().isNotEmpty) {
//                     return null;
//                   } else {
//                     return 'Please enter hub name';
//                   }
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'Hub name',
//                 ),
//               ),
//             ),
//             const Divider(
//               height: 30,
//               color: Color.fromARGB(66, 176, 176, 176),
//             ),
//             Text(
//               'Address',
//               style: Theme.of(context).textTheme.labelMedium?.copyWith(
//                     color: Colors.black45,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(height: 5),
//             CustomCard(
//               child: TextFormField(
//                 controller: _nameController,
//                 maxLines: 3,
//                 validator: (value) {
//                   if (value != null && value.trim().isNotEmpty) {
//                     return null;
//                   } else {
//                     return 'Please enter hub address';
//                   }
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'eg.adress line1, address line 2',
//                 ),
//               ),
//             ),
//             const Divider(
//               height: 30,
//               color: Color.fromARGB(66, 176, 176, 176),
//             ),
//             CustomActionButton(
//               color: Colors.grey[600]!,
//               iconData: Icons.upload_outlined,
//               onPressed: () async {},
//               label: 'Add Location',
//             ),
//             const Divider(
//               height: 30,
//               color: Color.fromARGB(66, 176, 176, 176),
//             ),
//             CustomButton(
//               labelColor: Colors.white,
//               label: widget.hubDetails != null ? 'Save' : 'Add',
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   if (widget.hubDetails != null) {
//                     // BlocProvider.of<PatientBloc>(context).add(
//                     //   EditPatientEvent(
//                     //     patientId: widget.patientDetails!['id'],
//                     //     name: _nameController.text.trim(),
//                     //     phone: _phoneNumberController.text.trim(),
//                     //     address: _addressController.text.trim(),
//                     //     city: _cityController.text.trim(),
//                     //     district: _districtController.text.trim(),
//                     //     dob: _dob!,
//                     //     gender: _gender,
//                     //     state: _stateController.text.trim(),
//                     //   ),
//                     // );
//                   } else {
//                     // BlocProvider.of<PatientBloc>(context).add(
//                     //   AddPatientEvent(
//                     //     name: _nameController.text.trim(),
//                     //     phone: _phoneNumberController.text.trim(),
//                     //     address: _addressController.text.trim(),
//                     //     city: _cityController.text.trim(),
//                     //     district: _districtController.text.trim(),
//                     //     dob: _dob!,
//                     //     gender: _gender,
//                     //     state: _stateController.text.trim(),
//                     //   ),
//                     // );
//                     Navigator.pop(context);
//                   }
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
