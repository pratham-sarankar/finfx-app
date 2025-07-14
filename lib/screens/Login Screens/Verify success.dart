// ignore_for_file: file_names

// Flutter imports:
import 'package:finfx/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../config/common.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _Succcess();
}

class _Succcess extends State<Success> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Padding(
        padding:
            const EdgeInsets.only(top: 50, bottom: 20, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: colorScheme.onSurface,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            AppConstants.Height(90),
            Center(
              child: Container(
                height: height / 3.6,
                // width: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/verify success.png"),
                  ),
                ),
              ),
            ),
            AppConstants.Height(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Thanks for completing your KYC verification process",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Manrope-Bold",
                    color: colorScheme.onSurface),
              ),
            ),
            AppConstants.Height(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "We are reviewing your Aadhar Card and PAN Card. Please wait while we verify your documents.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Manrope-Regular",
                    color: colorScheme.onSurface.withOpacity(0.6)),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              child: Container(
                // width: 327,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: colorScheme.primary),
                child: Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontFamily: "Manrope-Bold",
                      fontSize: 18,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
