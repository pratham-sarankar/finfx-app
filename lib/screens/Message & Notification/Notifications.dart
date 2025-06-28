// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../dark_mode.dart';
import '../config/common.dart';
import 'Information.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications>
    with SingleTickerProviderStateMixin {
  String selectedFilter = "Message";

  @override
  void initState() {
    super.initState();
  }

  ColorNotifire notifier = ColorNotifire();
  int status = 0;

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifire>(context, listen: true);
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: notifier.background,
      appBar: AppBar(
        backgroundColor: notifier.background,
        elevation: 0,
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
        title: Center(
          child: Text(
            "Notifications",
            style: TextStyle(
              color: notifier.textColor,
              fontSize: 16,
              fontFamily: "Manrope-Bold",
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                isScrollControlled: true,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        height: height / 2,
                        color: notifier.background,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Sort",
                                    style: TextStyle(
                                      fontFamily: "Manrope-Bold",
                                      fontSize: 16,
                                      color: notifier.textColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: notifier.textColor,
                                      ))
                                ],
                              ),
                              AppConstants.Height(10),
                              Divider(
                                color: notifier.getContainerBorder,
                                thickness: 1,
                              ),
                              AppConstants.Height(10),
                              GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      status = 0;
                                    },
                                  );
                                },
                                child: Container(
                                  height: height / 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: status == 0
                                              ? const Color(0xff6B39F4)
                                              : notifier.getContainerBorder)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "All Status",
                                          style: TextStyle(
                                              color: notifier.textColor,
                                              fontSize: 16,
                                              fontFamily: "Manrope-Regular"),
                                        ),
                                      ),
                                      const Spacer(),
                                      Radio(
                                        fillColor: WidgetStateColor.resolveWith(
                                            (states) =>
                                                const Color(0xff6B39F4)),
                                        // activeColor: const Color(0xff0056D2),
                                        value: 0,
                                        groupValue: status,
                                        onChanged: (index) {
                                          setState(
                                            () {
                                              status = 0;
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AppConstants.Height(10),
                              GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      status = 1;
                                    },
                                  );
                                },
                                child: Container(
                                  height: height / 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: status == 1
                                              ? const Color(0xff6B39F4)
                                              : notifier.getContainerBorder)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Already Read",
                                          style: TextStyle(
                                              color: notifier.textColor,
                                              fontSize: 16,
                                              fontFamily: "Manrope-Regular"),
                                        ),
                                      ),
                                      const Spacer(),
                                      Radio(
                                        fillColor: WidgetStateColor.resolveWith(
                                            (states) =>
                                                const Color(0xff6B39F4)),
                                        // activeColor: const Color(0xff0056D2),
                                        value: 1,
                                        groupValue: status,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              status = 1;
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AppConstants.Height(10),
                              GestureDetector(
                                onTap: () {
                                  setState(
                                    () {
                                      status = 2;
                                    },
                                  );
                                },
                                child: Container(
                                  height: height / 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: status == 2
                                              ? const Color(0xff6B39F4)
                                              : notifier.getContainerBorder)),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          "Unread",
                                          style: TextStyle(
                                              color: notifier.textColor,
                                              fontSize: 16,
                                              fontFamily: "Manrope-Regular"),
                                        ),
                                      ),
                                      const Spacer(),
                                      Radio(
                                        fillColor: WidgetStateColor.resolveWith(
                                            (states) =>
                                                const Color(0xff6B39F4)),
                                        // activeColor: const Color(0xff0056D2),
                                        value: 2,
                                        groupValue: status,
                                        onChanged: (value) {
                                          setState(
                                            () {
                                              status = 2;
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AppConstants.Height(10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color(0xff6B39F4)),
                                  child: const Center(
                                      child: Text("Done",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xffFFFFFF),
                                              fontFamily: "Manrope-Bold"))),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: Image.asset(
              "assets/images/arrows-sort.png",
              scale: 3,
              color: notifier.textColor,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Information(),
    );
  }
}
