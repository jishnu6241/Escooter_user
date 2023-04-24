import 'package:escooter/ui/screens/login.dart';
import 'package:escooter/ui/screens/complaint_screen.dart';
import 'package:escooter/ui/screens/suggestion_screen.dart';
import 'package:escooter/ui/widgets/change_password_dialog.dart';
import 'package:escooter/ui/widgets/custom_action_button.dart';
import 'package:escooter/ui/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Deposit',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            const DepositCard(),
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
                // SettingsCard(
                //   icon: Icons.person_4_outlined,
                //   label: 'Profile',
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => const ProfileScreen(),
                //       ),
                //     );
                //   },
                // ),
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
    );
  }
}

class DepositCard extends StatelessWidget {
  const DepositCard({
    super.key,
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
                '₹500',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Divider(
                height: 20,
                color: Colors.grey,
              ),
              CustomActionButton(
                color: Colors.red,
                iconData: Icons.money_off,
                onPressed: () {},
                label: 'Withdraw Deposit',
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
