import 'package:escooter/values/colors.dart';
import 'package:flutter/material.dart';

class Escooter extends StatefulWidget {
  const Escooter({super.key});

  @override
  State<Escooter> createState() => _EscooterState();
}

class _EscooterState extends State<Escooter>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
          )),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomSlider(
                label: "CURRENT RIDE INFO",
                isActive: _tabController.index == 0,
                onTap: () {
                  _tabController.animateTo(0);
                },
              ),
              CustomSlider(
                label: "HISTORY",
                isActive: _tabController.index == 1,
                onTap: () {
                  _tabController.animateTo(1);
                },
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                Container(
                  color: Colors.white,
                ),
                Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  final Function() onTap;
  final String label;
  final bool isActive;
  const CustomSlider({
    Key? key,
    required this.label,
    this.isActive = true,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isActive ? Colors.black : Colors.grey,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              height: 2,
              thickness: isActive ? 3 : 2,
              color: isActive ? primaryColor : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
