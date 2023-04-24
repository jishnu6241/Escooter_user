import 'package:escooter/ui/screens/login.dart';
import 'package:escooter/ui/screens/complaint_screen.dart';
import 'package:escooter/ui/screens/profile_creation_screen.dart';
import 'package:escooter/ui/screens/suggestion_screen.dart';
import 'package:escooter/ui/widgets/change_password_dialog.dart';
import 'package:escooter/ui/widgets/custom_action_button.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../blocs/auth/sign_up/sign_up_bloc.dart';
import '../widgets/custom_alert_dialog.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoading = false;
  final SignUpBloc signUpBloc = SignUpBloc();

  final Razorpay _razorpay = Razorpay();

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    await showDialog(
      context: context,
      builder: (context) => const CustomAlertDialog(
        title: 'Payment Success',
        message: 'Thank you for the payment. Reopen the page to see changes',
        primaryButtonLabel: 'Ok',
      ),
    );

    signUpBloc.add(DepositEvent());
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

  void makePayment() async {
    // String orderId = await createOrder(widget.testDetails['total_price']);

    var options = {
      'key': 'rzp_test_j07YpjyCexi5xr',
      'amount': 500 * 100,
      'name': 'Escooter',
      // 'order_id': orderId,
      'description': 'Security Deposit',
      'prefill': {
        'contact': '9988998899',
        'email': Supabase.instance.client.auth.currentUser!.email,
      }
    };
    Logger().w(options);
    _razorpay.open(options);
  }

  @override
  void initState() {
    super.initState();
    signUpBloc.add(GetUserEvent());
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              BlocProvider<SignUpBloc>.value(
                value: signUpBloc,
                child: BlocBuilder<SignUpBloc, SignUpState>(
                  builder: (context, state) {
                    return state is SignUpSuccessState
                        ? DepositCard(
                            amount: state.userDetails['deposit_amount'],
                            onPressed: (isDeposit) {
                              if (isDeposit) {
                                makePayment();
                              } else {
                                signUpBloc.add(DepositEvent(withdraw: true));
                              }
                            },
                          )
                        : const SizedBox();
                  },
                ),
              ),
              const Divider(
                height: 30,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  SettingsCard(
                    icon: Icons.report_outlined,
                    label: 'Reports',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ComplaintsScreen(),
                        ),
                      );
                    },
                  ),
                  SettingsCard(
                    icon: Icons.report_outlined,
                    label: 'Suggestions',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuggestionsScreen(),
                        ),
                      );
                    },
                  ),
                  BlocProvider<SignUpBloc>.value(
                    value: signUpBloc,
                    child: BlocBuilder<SignUpBloc, SignUpState>(
                      builder: (context, state) {
                        return state is SignUpSuccessState
                            ? SettingsCard(
                                icon: Icons.person_4_outlined,
                                label: 'Profile',
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileCreationScreen(
                                        profileDetails: state.userDetails,
                                      ),
                                    ),
                                  );
                                  signUpBloc.add(GetUserEvent());
                                },
                              )
                            : const SizedBox();
                      },
                    ),
                  ),
                  SettingsCard(
                    icon: Icons.lock_open_outlined,
                    label: 'Change Password',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (builder) => const ChangePasswordDialog(),
                      );
                    },
                  ),
                  SettingsCard(
                    icon: Icons.logout_outlined,
                    label: isLoading ? 'Logging out...' : 'Logout',
                    onTap: isLoading
                        ? () {}
                        : () async {
                            isLoading = true;
                            setState(() {});

                            await Supabase.instance.client.auth.signOut();

                            isLoading = false;
                            setState(() {});

                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => true,
                            );
                          },
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

class DepositCard extends StatelessWidget {
  final int amount;
  final Function(bool) onPressed;
  const DepositCard({
    super.key,
    required this.amount,
    required this.onPressed,
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
                'Deposit'.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white54,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                '₹${amount.toString()}',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Divider(
                height: 20,
                color: Colors.grey,
              ),
              CustomActionButton(
                color: amount > 0 ? Colors.red : Colors.greenAccent,
                iconData: amount > 0 ? Icons.money_off : Icons.money,
                onPressed: () {
                  if (amount > 0) {
                    onPressed(false);
                  } else {
                    onPressed(true);
                  }
                },
                label: amount > 0 ? 'Withdraw Deposit' : 'Deposit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function() onTap;

  const SettingsCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: Colors.greenAccent[100],
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.green[700],
              size: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
