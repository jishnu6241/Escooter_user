import 'package:escooter/ui/screens/rides_screen.dart';
import 'package:escooter/ui/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.greenAccent,
        ),
        title: Text(
          'E Scooter',
          style: GoogleFonts.sedgwickAveDisplay(
            textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        elevation: 1,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          RidesScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: Material(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.greenAccent[100],
        elevation: 10,
        child: CustomBottomNavBar(
          selectedIndex: tabController.index,
          onChanged: (int index) {
            tabController.animateTo(index);
            setState(() {});
          },
        ),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onChanged;
  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        NavBarButton(
          label: 'Ride',
          iconData: Icons.electric_moped_outlined,
          selectedIconData: Icons.electric_moped,
          onPressed: () {
            onChanged(0);
          },
          isSelected: selectedIndex == 0,
        ),
        NavBarButton(
          label: 'Settings',
          iconData: Icons.settings_outlined,
          selectedIconData: Icons.settings,
          onPressed: () {
            onChanged(1);
          },
          isSelected: selectedIndex == 1,
        ),
      ],
    );
  }
}

class NavBarButton extends StatelessWidget {
  final IconData iconData, selectedIconData;
  final String label;
  final Function() onPressed;
  final bool isSelected;
  const NavBarButton({
    Key? key,
    required this.iconData,
    required this.selectedIconData,
    required this.onPressed,
    required this.isSelected,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              Icon(
                isSelected ? selectedIconData : iconData,
                size: 24,
                color: Colors.black,
              ),
              if (isSelected) const SizedBox(width: 20),
              if (isSelected)
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
