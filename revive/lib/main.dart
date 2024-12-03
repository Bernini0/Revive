import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revive/model/subscription_purchases.dart';
import 'package:revive/presentation/view/home_screen.dart';
import 'package:revive/presentation/view/landing_screen.dart';
import 'package:revive/presentation/view/sign_in_screen.dart';
import 'package:revive/presentation/view/sign_up_screen.dart';
import 'package:revive/utils/theme_data.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SubscriptionPurchases(),
      child: MaterialApp(
        home: LandingScreen(),
        theme: themeData(context),
        themeMode: ThemeMode.light,
      ),
      lazy: false,
    );
  }
}
