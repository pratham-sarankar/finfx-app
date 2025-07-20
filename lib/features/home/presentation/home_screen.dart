// Flutter imports:
import 'package:finfx/features/brokers/presentation/screens/brokers_screen.dart';
import 'package:finfx/features/subscriptions/presentation/screens/my_subscriptions_screen.dart';
import 'package:flutter/material.dart';

// Project imports:
import 'package:finfx/features/profile/presentation/profile.dart';
import 'package:finfx/features/user_trades/presentation/screens/user_trades_screen.dart';
import 'package:finfx/features/home/presentation/home_tab_screen.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;
  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Create the HomeTabScreen first so it can use the callback
    final homeTab = HomeTabScreen(
      onSettingsTap: () {
        setState(() {
          currentIndex = 4;
        });
      },
    );
    final myChildren = [
      homeTab,
      const UserTradesScreen(),
      // const BotScreen(),
      // const Portfolio(),
      const MySubscriptionsScreen(),
      const BrokersScreen(),
      const Profile(),
    ];
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Align(
      //   alignment: const Alignment(0, 0.99),
      //   child: FloatingActionButton(
      //     onPressed: () {
      //       setState(() {
      //         currentIndex = 2;
      //       });
      //     },
      //     backgroundColor: const Color(0xff2e9844),
      //     child: Image(
      //       image: const AssetImage("assets/images/robot.png"),
      //       fit: BoxFit.contain,
      //       color: Colors.white,
      //       height: 26,
      //       width: 26,
      //     ),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorScheme.surface,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        elevation: 10,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 8,
        unselectedFontSize: 8,
        iconSize: 20,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.6),
        selectedItemColor: colorScheme.primary,
        unselectedLabelStyle: const TextStyle(
          fontFamily: "Manrope_bold",
          fontSize: 8,
          letterSpacing: 0.2,
        ),
        selectedLabelStyle: const TextStyle(
          fontFamily: "Manrope_bold",
          fontSize: 8,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/home.png",
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            activeIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/home_fill.png",
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/Market_fill.png",
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            activeIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/Market_fill.png",
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            label: "Trades",
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/Portfolio.png",
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            activeIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/Portfolio_fill.png",
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            label: "Subscriptions",
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/Portfolio.png",
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            activeIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/Portfolio_fill.png",
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            label: "Broker",
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/Person.png",
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            activeIcon: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Image.asset(
                    "assets/images/Person_fill.png",
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            label: "Profile",
          ),
        ],
      ),
      body: myChildren.elementAt(currentIndex),
    );
  }
}
