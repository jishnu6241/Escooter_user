import 'package:dotted_border/dotted_border.dart';
import 'package:escooter/ui/widget/custom_button.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { nationalid, passport }

class Identification extends StatefulWidget {
  const Identification({super.key});

  @override
  State<Identification> createState() => _IdentificationState();
}

class _IdentificationState extends State<Identification> {
  SingingCharacter? _character = SingingCharacter.nationalid;
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
              "Identification",
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
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          RadioListTile<SingingCharacter>(
            activeColor: const Color(0xFF3FD5DF),
            title: const Text('National ID'),
            value: SingingCharacter.nationalid,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          RadioListTile<SingingCharacter>(
            activeColor: const Color(0xFF3FD5DF),
            title: const Text('Passport'),
            value: SingingCharacter.passport,
            groupValue: _character,
            onChanged: (SingingCharacter? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          _character == SingingCharacter.nationalid
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                            hintText: "National ID Number",
                            filled: true,
                            fillColor: Color(0xFFD9D9D9)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Upload your photo ID",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              DottedBorder(
                                color: Colors.green,
                                strokeWidth: 3,
                                dashPattern: const [6, 6],
                                child: const Material(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 20,
                                    ),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 34,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Front"),
                            ],
                          ),
                          Column(
                            children: [
                              DottedBorder(
                                color: Colors.green,
                                strokeWidth: 3,
                                dashPattern: const [6, 6],
                                child: const Material(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 20,
                                    ),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 34,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("back"),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 240,
                      ),
                      const CustomButton(
                        text: "NEXT",
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(
                            hintText: "Passport No.",
                            filled: true,
                            fillColor: Color(0xFFD9D9D9)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Upload your photo ID",
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              DottedBorder(
                                color: Colors.green,
                                strokeWidth: 3,
                                dashPattern: const [6, 6],
                                child: const Material(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 20,
                                    ),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 34,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("Front"),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              DottedBorder(
                                color: Colors.green,
                                strokeWidth: 3,
                                dashPattern: const [6, 6],
                                child: const Material(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 40,
                                      vertical: 20,
                                    ),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      size: 34,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text("back"),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 240,
                      ),
                      const CustomButton(
                        text: "NEXT",
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
