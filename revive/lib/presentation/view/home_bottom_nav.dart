import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:revive/presentation/view/home_screen.dart';
import 'package:revive/presentation/view/landing_screen.dart';
import 'package:revive/presentation/view/settings_screen.dart';

import '../../utils/constants.dart';

class HomeBottomNav extends StatefulWidget {
  const HomeBottomNav({super.key});

  @override
  State<HomeBottomNav> createState() => _HomeBottomNavState();
}

class _HomeBottomNavState extends State<HomeBottomNav> {
  int pageIndex = 0;

  List<Widget> pageList = <Widget>[
    HomeScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: PageTransitionSwitcher(
        transitionBuilder: (
          child,
          primaryAnimation,
          secondaryAnimation,
        ) =>
            FadeThroughTransition(
          fillColor: Colors.black,
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: pageList[pageIndex],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GNav(
            selectedIndex: pageIndex,
            onTabChange: (value) {
              print(value);
              setState(() {
                pageIndex = value;
              });
            },
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            backgroundColor: Colors.transparent,
            tabBackgroundColor: Colors.black,
            color: Colors.white,
            activeColor: kPrimary,
            gap: 8,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            tabs: [
              GButton(
                icon: Icons.enhance_photo_translate,
                text: 'Enhance',
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  await GoogleSignIn().signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LandingScreen()),
                      (Route<dynamic> route) => false);
                },
              ),
              GButton(
                icon: Icons.settings_outlined,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
