import 'package:flutter/material.dart';

import '../widget/custom_button.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFDFDFDF),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Set up Your Profile",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              width: 50,
            ),
          ],
        ),
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            TextField(
              decoration: InputDecoration(
                hintText: "First Name",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Last Name",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Email ID",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Mobile Number",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Password",
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Confirm Password",
              ),
            ),
            SizedBox(
              height: 50,
            ),
            CustomButton(
              text: "Proceed",
            ),
          ],
        ),
      ),
    );
  }
}
