import 'package:flutter/material.dart';

import '../widget/custom_button.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
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
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              children: [
                const SizedBox(
                  height: 90,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  Enter Your E-mail",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: '',
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "  Enter Your Password",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: '',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Forget password?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("New Member?"),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Create account",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 240,
                ),
                const CustomButton(text: "Login")
              ],
            ),
          ),
        ));
  }
}
