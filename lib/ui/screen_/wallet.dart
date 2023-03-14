import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

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
              "My Wallet",
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 66, 253, 33),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$ 0",
                          style: GoogleFonts.roboto(
                              textStyle:
                                  Theme.of(context).textTheme.headlineMedium,
                              color: Colors.white70),
                        ),
                        Image.asset(
                          "assets/images/wallet.png",
                          fit: BoxFit.cover,
                          height: 50,
                          width: 50,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Recharge your wallet with a higher to avoid repeated  top-ups",
                      style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.labelLarge,
                          color: Colors.white70),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "WITHDRAW",
                      style: GoogleFonts.roboto(
                          textStyle: Theme.of(context).textTheme.subtitle1,
                          color: Colors.white70,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                elevation: 5,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Transactions",
                            style: GoogleFonts.roboto(
                                textStyle:
                                    Theme.of(context).textTheme.headline5,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 15,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("0 Transactions this month"),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Material(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Add money to Wallet",
                        style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.subtitle1,
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
