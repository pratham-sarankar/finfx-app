// ignore_for_file: file_names, camel_case_types

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:crowwn/screens/config/common.dart';
import '../../Dark mode.dart';
import 'Top up confirmation.dart';

class Top_payment extends StatefulWidget {
  const Top_payment({super.key});

  @override
  State<Top_payment> createState() => _Top_paymentState();
}

class _Top_paymentState extends State<Top_payment> {
  int selectedFilter = 0;
  ColorNotifire notifier = ColorNotifire();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifire>(context, listen: true);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            "assets/images/arrow-narrow-left (1).png",
            scale: 3,
            color: notifier.textColor,
          ),
        ),
        title: Text(
          "Deposit Method",
          style: TextStyle(
            fontFamily: "Manrope-Bold",
            fontSize: 16,
            color: notifier.textColor,
          ),
        ),
        backgroundColor: notifier.background,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppConstants.Height(20),
              Text(
                "Bank Transfer",
                style: TextStyle(
                  fontSize: 16,
                  color: notifier.textColor,
                  fontFamily: "Manrope-Bold",
                ),
              ),
              AppConstants.Height(20),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      selectedFilter = 0;
                    },
                  );
                },
                child: Container(
                  height: height / 8.5,
                  // width: 365,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selectedFilter == 0
                          ? const Color(0xff6B39F4)
                          : notifier.getContainerBorder,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: height / 14,
                              width: width / 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: notifier.onboardBackgroundColor,
                              ),
                              child: Image.asset(
                                "assets/images/Bank America icon.png",
                                height: 30,
                                width: 30,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Bank of America",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: notifier.textColor,
                                      fontFamily: "Manrope-Bold",
                                    ),
                                  ),
                                  AppConstants.Height(10),
                                  const Text(
                                    "Checked automatically",
                                    style: TextStyle(
                                      color: Color(0xff64748B),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Radio(
                                    fillColor: WidgetStateColor.resolveWith(
                                        (states) => const Color(0xff6B39F4)),
                                    // activeColor: const Color(0xff0056D2),
                                    value: 0,
                                    groupValue: selectedFilter,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          selectedFilter = 0;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppConstants.Height(20),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      selectedFilter = 1;
                    },
                  );
                },
                child: Container(
                  height: height / 8.5,
                  // width: 365,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selectedFilter == 1
                          ? const Color(0xff6B39F4)
                          : notifier.getContainerBorder,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: height / 14,
                              width: width / 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: notifier.onboardBackgroundColor,
                              ),
                              child: Image.asset(
                                "assets/images/Barclays outlined.png",
                                width: 25,
                                height: 25,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Barclays",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: notifier.textColor,
                                        fontFamily: "Manrope-Bold"),
                                  ),
                                  AppConstants.Height(10),
                                  const Text(
                                    "Checked automatically",
                                    style: TextStyle(
                                      color: Color(0xff64748B),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Radio(
                                    fillColor: WidgetStateColor.resolveWith(
                                      (states) => const Color(0xff6B39F4),
                                    ),
                                    // activeColor: const Color(0xff0056D2),
                                    value: 1,
                                    groupValue: selectedFilter,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          selectedFilter = 1;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppConstants.Height(20),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      selectedFilter = 2;
                    },
                  );
                },
                child: Container(
                  height: height / 8.5,
                  // width: 365,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selectedFilter == 2
                          ? const Color(0xff6B39F4)
                          : notifier.getContainerBorder,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: height / 14,
                              width: width / 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: notifier.onboardBackgroundColor,
                              ),
                              child: Image.asset(
                                "assets/images/WellsFargo outlined - png.png",
                                width: 25,
                                height: 25,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Wells Fargo",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: notifier.textColor,
                                        fontFamily: "Manrope-Bold"),
                                  ),
                                  AppConstants.Height(10),
                                  const Text(
                                    "Checked automatically",
                                    style: TextStyle(
                                      color: Color(0xff64748B),
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Radio(
                                    fillColor: WidgetStateColor.resolveWith(
                                      (states) => const Color(0xff6B39F4),
                                    ),
                                    // activeColor: const Color(0xff0056D2),
                                    value: 2,
                                    groupValue: selectedFilter,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          selectedFilter = 2;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppConstants.Height(20),
              Text(
                "Credit/Debit Card",
                style: TextStyle(
                  fontSize: 16,
                  color: notifier.textColor,
                  fontFamily: "Manrope-Bold",
                ),
              ),
              AppConstants.Height(20),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      selectedFilter = 3;
                    },
                  );
                },
                child: Container(
                  height: height / 8.5,
                  // width: 365,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selectedFilter == 3
                          ? const Color(0xff6B39F4)
                          : notifier.getContainerBorder,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: height / 14,
                              width: width / 8,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: notifier.onboardBackgroundColor),
                              child: Image.asset(
                                "assets/images/Visa Outlined.png",
                                height: 25,
                                width: 25,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Visa",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: notifier.textColor,
                                        fontFamily: "Manrope-Bold"),
                                  ),
                                  AppConstants.Height(10),
                                  const Text("**** **** **** 4567",
                                      style: TextStyle(
                                          color: Color(0xff64748B),
                                          fontSize: 13)),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Radio(
                                    fillColor: WidgetStateColor.resolveWith(
                                        (states) => const Color(0xff6B39F4)),
                                    // activeColor: const Color(0xff0056D2),
                                    value: 3,
                                    groupValue: selectedFilter,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          selectedFilter = 3;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppConstants.Height(20),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      selectedFilter = 4;
                    },
                  );
                },
                child: Container(
                  height: height / 8.5,
                  // width: 365,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selectedFilter == 4
                          ? const Color(0xff6B39F4)
                          : notifier.getContainerBorder,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: height / 14,
                              width: width / 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: notifier.onboardBackgroundColor,
                              ),
                              child: Image.asset(
                                "assets/images/Mastercard Outlined.png",
                                height: 25,
                                width: 25,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Mastercard",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: notifier.textColor,
                                    fontFamily: "Manrope-Bold",
                                  ),
                                ),
                                AppConstants.Height(10),
                                const Text(
                                  "**** **** **** 3456",
                                  style: TextStyle(
                                    color: Color(0xff64748B),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Column(
                                children: [
                                  Radio(
                                    fillColor: WidgetStateColor.resolveWith(
                                      (states) => const Color(0xff6B39F4),
                                    ),
                                    // activeColor: const Color(0xff0056D2),
                                    value: 4,
                                    groupValue: selectedFilter,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          selectedFilter = 4;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppConstants.Height(20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 5, right: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Top_confirmation(),
              ),
            );
          },
          child: Container(
            height: 56,
            width: 370,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xff6B39F4),
            ),
            child: const Center(
                child: Text("Confirm",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "̌Manrope-Bold"))),
          ),
        ),
      ),
    );
  }
}
