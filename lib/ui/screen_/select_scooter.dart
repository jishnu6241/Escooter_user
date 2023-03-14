import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Selesooter extends StatelessWidget {
  const Selesooter({super.key});
  // final _headerStyle = const TextStyle(
  //     color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  // final _contentStyleHeader = const TextStyle(
  //     color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  // final _contentStyle = const TextStyle(
  //     color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

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
              "Select E-Scooter",
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Parassinikkadavu",
              style: GoogleFonts.roboto(
                  textStyle: Theme.of(context).textTheme.headline6),
            ),
            Accordion(
              maxOpenSections: 2,
              headerBackgroundColorOpened: Colors.black54,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                //TODO: change implementation
                AccordionSection(
                  isOpen: true,
                  rightIcon: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.white),
                  headerBackgroundColor: Colors.blue,
                  headerBackgroundColorOpened: Colors.green,
                  header: Text(
                    'Good Condition Scooters',
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                  ),
                  content: SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [
                          CustomScooterCard(
                            scooterConditon: ScooterConditon.good,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomScooterCard(
                            scooterConditon: ScooterConditon.good,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomScooterCard(
                            scooterConditon: ScooterConditon.good,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomScooterCard(
                            scooterConditon: ScooterConditon.good,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomScooterCard(
                            scooterConditon: ScooterConditon.good,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  contentHorizontalPadding: 20,
                  contentBorderWidth: 0,
                ),
                AccordionSection(
                  isOpen: true,
                  header: Text('Bad Condition Scooters',
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          fontWeight: FontWeight.w400, color: Colors.white)),
                  contentBorderColor: const Color(0xffffffff),
                  headerBackgroundColorOpened: Colors.red,
                  content: SizedBox(
                    height: 200,
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [
                          CustomScooterCard(
                            scooterConditon: ScooterConditon.bad,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomScooterCard(
                            scooterConditon: ScooterConditon.bad,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomScooterCard(
                            scooterConditon: ScooterConditon.bad,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomScooterCard(
                            scooterConditon: ScooterConditon.bad,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomScooterCard(
                            scooterConditon: ScooterConditon.bad,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum ScooterConditon { good, bad }

class CustomScooterCard extends StatelessWidget {
  final ScooterConditon scooterConditon;
  const CustomScooterCard({
    Key? key,
    required this.scooterConditon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          width: 2,
          color: Color(0xFF3FD5DF),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "KL 13 AU 6241",
              style: Theme.of(context).textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            scooterConditon == ScooterConditon.good
                ? const RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.battery_4_bar,
                      color: Colors.lightGreen,
                    ),
                  )
                : const Icon(
                    Icons.block,
                    color: Colors.red,
                  )
          ],
        ),
      ),
    );
  }
}
