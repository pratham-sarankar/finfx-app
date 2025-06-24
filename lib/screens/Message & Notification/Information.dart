// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:crowwn/screens/config/activity_model.dart';
import 'package:crowwn/screens/config/common.dart';
import '../../dark_mode.dart';
import 'Notification_detail.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  ColorNotifire notifier = ColorNotifire();
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              ListView.builder(
                itemCount: model.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Activity_Model data = model[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Notification_detail(
                              image: data.image,
                              name: data.name,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 0,
                        color: Colors.transparent,
                        margin: EdgeInsets.zero,
                        shape: Border(
                            bottom: BorderSide(
                                color: notifier.getContainerBorder, width: 1)),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.asset(
                            data.image,
                            scale: 3,
                          ),
                          title: Text(
                            data.name,
                            style: TextStyle(
                                fontSize: 14,
                                color: notifier.textColor,
                                fontFamily: "Manrope-Bold"),
                          ),
                          subtitle: Text(
                            data.subtitle,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff64748B),
                                fontFamily: "Manrope-Regular"),
                          ),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                data.time,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff64748B),
                                    fontFamily: "Manrope-Regular"),
                              ),
                              AppConstants.Height(5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
