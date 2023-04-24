import 'package:escooter/blocs/auth/sign_up/sign_up_bloc.dart';
import 'package:escooter/ui/screens/home_screen.dart';
import 'package:escooter/ui/widgets/custom_action_button.dart';
import 'package:escooter/ui/widgets/custom_alert_dialog.dart';
import 'package:escooter/ui/widgets/custom_button.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/ui/widgets/custom_input_form_field.dart';
import 'package:escooter/util/custom_file_picker.dart';
import 'package:escooter/util/value_validators.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileCreationScreen extends StatefulWidget {
  final dynamic profileDetails;
  const ProfileCreationScreen({
    super.key,
    this.profileDetails,
  });

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  bool isObscure = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _acNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  PlatformFile? selectedFile;

  @override
  void initState() {
    super.initState();
    if (widget.profileDetails != null) {
      _nameController.text = widget.profileDetails['name'];
      _phoneController.text = widget.profileDetails['phone'];
      _emailController.text = widget.profileDetails['email'];
      _bankNameController.text = widget.profileDetails['bank_name'];
      _acNumberController.text = widget.profileDetails['bank_ac_no'];
      _ifscController.text = widget.profileDetails['bank_ifsc'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1580634240125-b9f6ff4283d1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1171&q=80',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomCard(
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: BlocProvider<SignUpBloc>(
                    create: (context) => SignUpBloc(),
                    child: BlocConsumer<SignUpBloc, SignUpState>(
                      listener: (context, state) {
                        if (state is SignUpFailureState) {
                          showDialog(
                            context: context,
                            builder: (context) => CustomAlertDialog(
                              title: 'Failed',
                              message: state.message,
                              primaryButtonLabel: 'Ok',
                            ),
                          );
                        } else if (state is SignUpSuccessState) {
                          if (widget.profileDetails != null) {
                            Navigator.pop(context);
                          } else {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        }
                      },
                      builder: (context, state) {
                        return Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'E Scooter',
                                style: GoogleFonts.sedgwickAveDisplay(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .copyWith(
                                        color: Colors.greenAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Enter the following details to continue',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const Divider(
                                color: Colors.greenAccent,
                                height: 40,
                                thickness: 0.5,
                              ),
                              CustomInputFormField(
                                controller: _nameController,
                                prefixIcon: Icons.person_4_outlined,
                                labelText: 'Name',
                                validator: alphabeticWithSpaceValidator,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomInputFormField(
                                controller: _emailController,
                                prefixIcon: Icons.email,
                                labelText: 'Email',
                                validator: emailValidator,
                              ),
                              if (widget.profileDetails == null)
                                const SizedBox(
                                  height: 10,
                                ),
                              if (widget.profileDetails == null)
                                CustomInputFormField(
                                  controller: _passwordController,
                                  isObscure: isObscure,
                                  labelText: 'Password',
                                  prefixIcon: Icons.lock,
                                  validator: passwordValidator,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      isObscure = !isObscure;
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Colors.green[700],
                                    ),
                                  ),
                                ),
                              if (widget.profileDetails == null)
                                const SizedBox(
                                  height: 10,
                                ),
                              if (widget.profileDetails == null)
                                CustomInputFormField(
                                  controller: _confirmPasswordController,
                                  isObscure: isObscure,
                                  labelText: 'Confirm Password',
                                  prefixIcon: Icons.lock,
                                  validator: (value) {
                                    return confirmPasswordValidator(
                                        value, _passwordController.text.trim());
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
                                validator: phoneNumberValidator,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomInputFormField(
                                controller: _bankNameController,
                                labelText: 'Bank Name',
                                prefixIcon: Icons.money_outlined,
                                validator: alphabeticWithSpaceValidator,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomInputFormField(
                                controller: _acNumberController,
                                keyboardType: TextInputType.number,
                                labelText: 'Account Number',
                                prefixIcon: Icons.money_outlined,
                                validator: bankAccountNumberValidator,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomInputFormField(
                                controller: _ifscController,
                                labelText: 'IFSC Code',
                                prefixIcon: Icons.money_outlined,
                                validator: ifscCodeValidator,
                              ),
                              if (widget.profileDetails == null)
                                const SizedBox(
                                  height: 20,
                                ),
                              if (widget.profileDetails == null)
                                CustomActionButton(
                                  iconData: selectedFile != null
                                      ? Icons.check_outlined
                                      : Icons.upload_outlined,
                                  onPressed: () async {
                                    PlatformFile? file = await pickFile();
                                    if (file != null) {
                                      selectedFile = file;
                                      setState(() {});
                                    }
                                  },
                                  label: selectedFile != null
                                      ? 'Selected'
                                      : 'Upload Proof',
                                ),
                              const Divider(
                                color: Colors.white,
                                height: 20,
                              ),
                              if (widget.profileDetails != null)
                                CustomButton(
                                  labelColor: Colors.black,
                                  label: 'Update',
                                  isLoading: state is SignUpLoadingState,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<SignUpBloc>(context).add(
                                        UpdateUserEvent(
                                          accountNo:
                                              _acNumberController.text.trim(),
                                          bankName:
                                              _bankNameController.text.trim(),
                                          email: _emailController.text.trim(),
                                          ifsc: _ifscController.text.trim(),
                                          name: _nameController.text.trim(),
                                          password:
                                              _passwordController.text.trim(),
                                          phoneNumber:
                                              _phoneController.text.trim(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              if (widget.profileDetails == null)
                                CustomButton(
                                  labelColor: Colors.black,
                                  label: 'Register',
                                  isLoading: state is SignUpLoadingState,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      if (selectedFile != null) {
                                        BlocProvider.of<SignUpBloc>(context)
                                            .add(
                                          CreateUserEvent(
                                            accountNo:
                                                _acNumberController.text.trim(),
                                            bankName:
                                                _bankNameController.text.trim(),
                                            email: _emailController.text.trim(),
                                            ifsc: _ifscController.text.trim(),
                                            name: _nameController.text.trim(),
                                            password:
                                                _passwordController.text.trim(),
                                            phoneNumber:
                                                _phoneController.text.trim(),
                                            proofDoc: selectedFile!,
                                          ),
                                        );
                                      } else {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const CustomAlertDialog(
                                            title: 'Select Proof',
                                            message:
                                                'Select a proof file to continue',
                                            primaryButtonLabel: 'Ok',
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                              if (widget.profileDetails == null)
                                const Divider(
                                  color: Colors.white,
                                  height: 20,
                                ),
                              if (widget.profileDetails == null)
                                CustomButton(
                                  color: Colors.black,
                                  labelColor: Colors.greenAccent,
                                  label: 'Login',
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
