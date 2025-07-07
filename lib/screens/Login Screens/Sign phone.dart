// ignore_for_file: file_names, camel_case_types

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:crowwn/screens/Login%20Screens/Create%20pin.dart';
import '../../dark_mode.dart';
import '../../services/auth_service.dart';
import '../config/common.dart';

class phone extends StatefulWidget {
  const phone({super.key});

  @override
  State<phone> createState() => _phoneState();
}

class _phoneState extends State<phone> {
  ColorNotifire notifier = ColorNotifire();
  String selectedCountryCode = '+91'; // Default to India
  String selectedCountryFlag = '🇮🇳';
  final TextEditingController _phoneController = TextEditingController();
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = context.read<AuthService>();
  }

  void _sendOtp() async {
    try {
      final response = await _authService.sendPhoneOtp(_phoneController.text);
      print(response['message']);
      // Navigate to the OTP screen
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifire>(context, listen: true);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: notifier.background,
      appBar: AppBar(
        backgroundColor: notifier.background,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.close,
              color: notifier.textColor,
              size: 25,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppConstants.Height(70),
            Text(
              "Almost Done!",
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Manrope-SemiBold",
                  color: notifier.textColor),
            ),
            AppConstants.Height(20),
            const Text(
              "Enter your phone number and we'll text you a \n code to activate your account.",
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff64748B),
                  fontFamily: "Manrope-Medium"),
            ),
            AppConstants.Height(20),
            Container(
              height: 56,
              width: 226,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: notifier.textField,
              ),
              child: TextField(
                controller: _phoneController,
                style: TextStyle(color: notifier.textColor),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(color: Color(0xff64748B)),
                ),
              ),
            ),
            AppConstants.Height(30),
            GestureDetector(
              onTap: _sendOtp,
              child: Container(
                height: height / 11,
                decoration: BoxDecoration(
                    color: const Color(0xff2e9844),
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                    child: Text("Send OTP",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: "Manrope-Bold"))),
              ),
            ),
            AppConstants.Height(20),
            GestureDetector(
              onTap: () {
                // Handle skip action, e.g., navigate to the next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Pin(), // Assuming CreatePin is the next screen
                  ),
                );
              },
              child: const Center(
                child: Text(
                  "Skip",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff2e9844),
                      fontFamily: "Manrope-Bold"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
