import 'package:escooter/ui/widgets/custom_button.dart';
import 'package:escooter/ui/widgets/custom_input_form_field.dart';
import 'package:escooter/ui/widgets/user_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _depostiController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _acNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Profile',
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
              // const UserCard(),
              // const Divider(
              //   height: 20,
              // ),
              Expanded(
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      CustomInputFormField(
                        controller: _nameController,
                        prefixIcon: Icons.person_4_outlined,
                        labelText: 'Name',
                        validator: (value) {
                          if (value != null && value.trim().isNotEmpty) {
                            return null;
                          } else {
                            return "Please enter name";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomInputFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        labelText: 'Phone',
                        prefixIcon: Icons.lock,
                        validator: (value) {
                          if (value != null && value.trim().isNotEmpty) {
                            return null;
                          } else {
                            return "Please enter phone";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomInputFormField(
                        controller: _bankNameController,
                        labelText: 'Bank Name',
                        prefixIcon: Icons.money_outlined,
                        validator: (value) {
                          if (value != null && value.trim().isNotEmpty) {
                            return null;
                          } else {
                            return "Please enter bank name";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomInputFormField(
                        controller: _acNumberController,
                        keyboardType: TextInputType.number,
                        labelText: 'Account Number',
                        prefixIcon: Icons.money_outlined,
                        validator: (value) {
                          if (value != null && value.trim().isNotEmpty) {
                            return null;
                          } else {
                            return "Please enter account number";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomInputFormField(
                        controller: _ifscController,
                        keyboardType: TextInputType.number,
                        labelText: 'IFSC Code',
                        prefixIcon: Icons.money_outlined,
                        validator: (value) {
                          if (value != null && value.trim().isNotEmpty) {
                            return null;
                          } else {
                            return "Please enter IFSC Code";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        labelColor: Colors.black,
                        label: 'Save',
                        //isLoading: state is SignInLoadingState,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // String email = _nameController.text.trim();
                            // String password = _phoneController.text.trim();

                            // BlocProvider.of<SignInBloc>(context).add(
                            //   SignInEvent(
                            //     email: email,
                            //     password: password,
                            //   ),
                            // );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
