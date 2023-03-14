import 'package:escooter/ui/screen_/profile_user.dart';
import 'package:escooter/ui/screen_/scooter.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(
      length: 5,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          Container(
            color: Colors.blue,
          ),
          const Escooter(),
          Container(
            color: Colors.white,
          ),
          Container(
            color: Colors.yellow,
          ),
          const UserProfile(),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomIconButton(
            iconData: Icons.home_outlined,
            isActive: _tabController.index == 0,
            onTap: () {
              _tabController.animateTo(0);
            },
          ),
          CustomIconButton(
            iconData: Icons.electric_moped,
            isActive: _tabController.index == 1,
            onTap: () {
              _tabController.animateTo(1);
            },
          ),
          CustomIconButton(
            iconData: Icons.wallet_outlined,
            isActive: _tabController.index == 2,
            onTap: () {
              _tabController.animateTo(2);
            },
          ),
          CustomIconButton(
            iconData: Icons.notifications_none_outlined,
            isActive: _tabController.index == 3,
            onTap: () {
              _tabController.animateTo(3);
            },
          ),
          CustomIconButton(
            iconData: Icons.account_circle_outlined,
            isActive: _tabController.index == 4,
            onTap: () {
              _tabController.animateTo(4);
            },
          ),
        ],
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final bool isActive;
  final Function() onTap;
  const CustomIconButton({
    super.key,
    this.isActive = false,
    required this.onTap,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          iconData,
          size: isActive ? 45 : 30,
          color: isActive ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
