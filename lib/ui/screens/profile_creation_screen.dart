import 'package:escooter/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:escooter/ui/screens/home_screen.dart';
import 'package:escooter/ui/widgets/custom_action_button.dart';
import 'package:escooter/ui/widgets/custom_button.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/ui/widgets/custom_input_form_field.dart';
import 'package:escooter/util/custom_file_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileCreationScreen extends StatefulWidget {
  const ProfileCreationScreen({super.key});

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  bool isObscure = true;
  @override
  void initState() {
    // Future.delayed(const Duration(milliseconds: 100), () {
    //   if (Supabase.instance.client.auth.currentUser != null) {
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (context) => const HomeScreen(),
    //       ),
    //     );
    //   }
    // });
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _depostiController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _acNumberController = TextEditingController();
  final TextEditingController _ifscController = TextEditingController();

  PlatformFile? selectedFile;

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
                  child: BlocProvider<SignInBloc>(
                    create: (context) => SignInBloc(),
                    child: BlocConsumer<SignInBloc, SignInState>(
                      listener: (context, state) {
                        if (state is SignInFailureState) {
                          showDialog(
                            context: context,
                            builder: (context) => const AlertDialog(
                              title: Text("Login Failed"),
                              content: Text(
                                'Please check your email and password and try again.',
                              ),
                            ),
                          );
                        } else if (state is SignInSuccessState) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
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
                                validator: (value) {
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
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
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
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
                                controller: _depostiController,
                                keyboardType: TextInputType.number,
                                labelText: 'Desposit(Minimum ₹500)',
                                prefixIcon: Icons.money_outlined,
                                validator: (value) {
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Please enter desposit";
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
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
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
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
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
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Please enter IFSC Code";
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
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
                                color: Colors.blueAccent,
                                height: 20,
                              ),
                              CustomButton(
                                labelColor: Colors.black,
                                label: 'Pay & Continue',
                                isLoading: state is SignInLoadingState,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    String email = _nameController.text.trim();
                                    String password =
                                        _phoneController.text.trim();

                                    BlocProvider.of<SignInBloc>(context).add(
                                      SignInEvent(
                                        email: email,
                                        password: password,
                                      ),
                                    );
                                  }
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
