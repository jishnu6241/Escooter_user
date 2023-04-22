// import 'package:escooter_admin/ui/widgets/custom_action_button.dart';
// import 'package:escooter_admin/ui/widgets/custom_alert_dialog.dart';
// import 'package:escooter_admin/ui/widgets/custom_button.dart';
// import 'package:escooter_admin/ui/widgets/custom_card.dart';
// import 'package:flutter/material.dart';

// class AddEditScooterDialog extends StatefulWidget {
//   final Map<String, dynamic>? scooterDetails;
//   const AddEditScooterDialog({
//     super.key,
//     this.scooterDetails,
//   });

//   @override
//   State<AddEditScooterDialog> createState() => _AddEditScooterDialogState();
// }

// class _AddEditScooterDialogState extends State<AddEditScooterDialog> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _plateNumberController = TextEditingController();

//   @override
//   void initState() {
//     if (widget.scooterDetails != null) {
//       _plateNumberController.text = widget.scooterDetails!['plate_no'];
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomAlertDialog(
//       width: 500,
//       title: widget.scooterDetails != null ? "Edit Scooter" : "Add Scooter",
//       message: widget.scooterDetails != null
//           ? "Change the following details and save to apply them"
//           : "Enter the following details to add a scooter",
//       content: Form(
//         key: _formKey,
//         child: ListView(
//           shrinkWrap: true,
//           children: [
//             Text(
//               'Plate Number',
//               style: Theme.of(context).textTheme.labelMedium?.copyWith(
//                     color: Colors.black45,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(height: 5),
//             CustomCard(
//               child: TextFormField(
//                 controller: _plateNumberController,
//                 validator: (value) {
//                   if (value != null && value.trim().isNotEmpty) {
//                     return null;
//                   } else {
//                     return 'Please enter plate number';
//                   }
//                 },
//                 decoration: const InputDecoration(
//                   hintText: 'eg.KL 13 AA 1234',
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
//               label: 'Select Hub',
//             ),
//             const Divider(
//               height: 30,
//               color: Color.fromARGB(66, 176, 176, 176),
//             ),
//             CustomButton(
//               labelColor: Colors.white,
//               label: widget.scooterDetails != null ? 'Save' : 'Add',
//               onPressed: () {
//                 if (_formKey.currentState!.validate()) {
//                   if (widget.scooterDetails != null) {
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
