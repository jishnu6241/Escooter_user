import 'package:escooter/blocs/auth/sign_in/sign_in_bloc.dart';
import 'package:escooter/ui/screens/home_screen.dart';
import 'package:escooter/ui/screens/profile_creation_screen.dart';
import 'package:escooter/ui/widgets/custom_button.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:escooter/ui/widgets/custom_input_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
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
                                'Enter email and password to register',
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
                                controller: _emailController,
                                prefixIcon: Icons.email,
                                labelText: 'Email',
                                validator: (value) {
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Please enter an email";
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomInputFormField(
                                controller: _passwordController,
                                isObscure: isObscure,
                                labelText: 'Password',
                                prefixIcon: Icons.lock,
                                validator: (value) {
                                  if (value != null &&
                                      value.trim().isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Please enter password";
                                  }
                                },
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
                              const SizedBox(
                                height: 10,
                              ),
                              CustomInputFormField(
                                controller: _confirmPasswordController,
                                isObscure: isObscure,
                                labelText: 'Confirm Password',
                                prefixIcon: Icons.lock,
                                validator: (value) {
                                  if (value != null &&
                                      value.trim().isNotEmpty &&
                                      _passwordController.text == value) {
                                    return null;
                                  } else {
                                    return "Please not matching";
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton(
                                labelColor: Colors.black,
                                label: 'Continue',
                                isLoading: state is SignInLoadingState,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileCreationScreen(),
                                    ),
                                  );
                                  // if (_formKey.currentState!.validate()) {
                                  //   String email = _emailController.text.trim();
                                  //   String password =
                                  //       _passwordController.text.trim();

                                  //   BlocProvider.of<SignInBloc>(context).add(
                                  //     SignInEvent(
                                  //       email: email,
                                  //       password: password,
                                  //     ),
                                  //   );
                                  // }
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
