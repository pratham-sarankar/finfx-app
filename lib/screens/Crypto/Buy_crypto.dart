// ignore_for_file: file_names, camel_case_types

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../dark_mode.dart';
import '../Order_Payment/Order crypto.dart';
import '../config/common.dart';

class Buy_crypto extends StatefulWidget {
  const Buy_crypto({super.key});

  @override
  State<Buy_crypto> createState() => _Buy_cryptoState();
}

class _Buy_cryptoState extends State<Buy_crypto> {
  ColorNotifire notifier = ColorNotifire();
  int index2 = 0;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifire>(context, listen: true);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: notifier.background,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            "assets/images/arrow-narrow-left (1).png",
            scale: 2.9,
            color: notifier.textColor,
          ),
        ),
        title: Center(
            child: Text("Buy ADA",
                style: TextStyle(fontSize: 16, color: notifier.textColor))),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Image.asset("assets/images/question-circle-outlined.png",
                width: 23, color: notifier.textFieldHintText),
          ),
        ],
        backgroundColor: notifier.background,
      ),
      body: Column(
        children: [
          AppConstants.Height(40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/cardano.png",
                width: 20,
                height: 20,
              ),
              AppConstants.Width(10),
              Column(
                children: [
                  Text(
                    "1 ADA = 0.35",
                    style: TextStyle(
                        color: notifier.textColor,
                        fontSize: 16,
                        fontFamily: "Manrope-Medium"),
                  ),
                ],
              )
            ],
          ),
          AppConstants.Height(70),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Container(
                          height: height / 12,
                          width: width / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: notifier.background,
                              border: Border.all(
                                  color: notifier.getContainerBorder)),
                          child: Center(
                            child: TextField(
                              style: TextStyle(
                                  color: notifier.textColor,
                                  fontFamily: "Manrope-Bold",
                                  fontSize: 40),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none),
                                  contentPadding: const EdgeInsets.only(
                                      bottom: 2, left: 8, top: 2)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: notifier.onboardBackgroundColor,
                            ),
                            child: Image.asset("assets/images/arrows-sort.png",
                                color: const Color(0xff2e9844), scale: 2.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppConstants.Height(10),
                  const Padding(
                    padding: EdgeInsets.only(left: 40),
                    child: Text(
                      "  USD balance 14,456.00",
                      style: TextStyle(color: Color(0xff64748B), fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
          AppConstants.Height(70),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index2 = 0;
                    });
                  },
                  child: Container(
                    height: height / 19,
                    width: width / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: index2 == 0
                          ? const Color(0xff2e9844)
                          : Colors.grey.withValues(alpha: 0.1),
                    ),
                    child: Center(
                        child: Text("25%",
                            style: TextStyle(
                                color: index2 == 0
                                    ? const Color(0xffFFFFFF)
                                    : const Color(0xff94A3B8),
                                fontSize: 14))),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index2 = 1;
                    });
                  },
                  child: Container(
                    height: height / 19,
                    width: width / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: index2 == 1
                          ? const Color(0xff2e9844)
                          : Colors.grey.withValues(alpha: 0.1),
                    ),
                    child: Center(
                        child: Text("50%",
                            style: TextStyle(
                                color: index2 == 1
                                    ? const Color(0xffFFFFFF)
                                    : const Color(0xff94A3B8),
                                fontSize: 14))),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index2 = 2;
                    });
                  },
                  child: Container(
                    height: height / 19,
                    width: width / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: index2 == 2
                          ? const Color(0xff2e9844)
                          : Colors.grey.withValues(alpha: 0.1),
                    ),
                    child: Center(
                        child: Text("75%",
                            style: TextStyle(
                                color: index2 == 2
                                    ? const Color(0xffFFFFFF)
                                    : const Color(0xff94A3B8),
                                fontSize: 14))),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index2 = 3;
                    });
                  },
                  child: Container(
                    height: height / 19,
                    width: width / 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: index2 == 3
                          ? const Color(0xff2e9844)
                          : Colors.grey.withValues(alpha: 0.1),
                    ),
                    child: Center(
                        child: Text("100%",
                            style: TextStyle(
                                color: index2 == 3
                                    ? const Color(0xffFFFFFF)
                                    : const Color(0xff94A3B8),
                                fontSize: 14))),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 15, right: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Order_cryp(),
                ));
          },
          child: Container(
            height: height / 12,
            width: width / 2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xff2e9844),
            ),
            child: const Center(
                child: Text("Buy",
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
