// ignore_for_file: file_names, camel_case_types

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:crowwn/screens/NFT/Collections.dart';
import 'package:crowwn/screens/NFT/Spacybox.dart';
import 'package:crowwn/screens/NFT/Statics.dart';
import 'package:crowwn/screens/config/common.dart';
import '../../dark_mode.dart';
import 'Hot bids see all.dart';
import 'Hot colletion see all.dart';
import 'Nemus Genesis.dart';
import 'Top collections see all.dart';

class nfts extends StatefulWidget {
  const nfts({super.key});

  @override
  State<nfts> createState() => _nftsState();
}

class _nftsState extends State<nfts> {
  ColorNotifire notifier = ColorNotifire();

  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifire>(context, listen: true);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: notifier.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppConstants.Height(10),
              Row(
                children: [
                  Text(
                    "Hot Collections",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Manrope-Bold",
                        color: notifier.textColor),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Hot_collection(),
                          ));
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: "Manrope-Medium",
                          color: Color(0xff6B39F4)),
                    ),
                  ),
                ],
              ),
              AppConstants.Height(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Nemus(),
                              ));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 56,
                              width: 56,
                              child: Image.asset("assets/images/Nemus 1.png"),
                            ),
                            Text("Nemus Ge...",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: notifier.textColor,
                                    fontFamily: "Manrope-SemiBold")),
                            const Text(
                              "\$95,987.00",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff64748B),
                                  fontFamily: "Manrope-Medium"),
                            ),
                          ],
                        ),
                      ),
                      AppConstants.Width(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Nemus(),
                              ));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 56,
                              width: 56,
                              child: Image.asset('assets/images/Stories 2.png'),
                            ),
                            Text("Stories from...",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: notifier.textColor,
                                    fontFamily: "Manrope-SemiBold")),
                            const Text(
                              "\$67,453.00",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff64748B),
                                  fontFamily: "Manrope-Medium"),
                            ),
                          ],
                        ),
                      ),
                      AppConstants.Width(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Nemus(),
                              ));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 56,
                              width: 56,
                              child: Image.asset("assets/images/Crystal 3.png"),
                            ),
                            Text("Crystal Do...",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: notifier.textColor,
                                    fontFamily: "Manrope-SemiBold")),
                            const Text(
                              "\$57,543.00",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff64748B),
                                  fontFamily: "Manrope-Medium"),
                            ),
                          ],
                        ),
                      ),
                      AppConstants.Width(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Nemus(),
                              ));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 56,
                              width: 56,
                              child: Image.asset("assets/images/Stories 2.png"),
                            ),
                            Text("Stories from...",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: notifier.textColor,
                                    fontFamily: "Manrope-SemiBold")),
                            const Text(
                              "\$67,453.00",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff64748B),
                                  fontFamily: "Manrope-Medium"),
                            ),
                          ],
                        ),
                      ),
                      AppConstants.Width(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Nemus(),
                              ));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 56,
                              width: 56,
                              child: Image.asset("assets/images/Nemus 1.png"),
                            ),
                            Text("Nemus Ge...",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: notifier.textColor,
                                    fontFamily: "Manrope-SemiBold")),
                            const Text(
                              "\$95,987.00",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff64748B),
                                  fontFamily: "Manrope-Medium"),
                            ),
                          ],
                        ),
                      ),
                      AppConstants.Width(10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Nemus(),
                              ));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 56,
                              width: 56,
                              child: Image.asset("assets/images/Crystal 3.png"),
                            ),
                            Text("Crystal Do...",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: notifier.textColor,
                                    fontFamily: "Manrope-SemiBold")),
                            const Text(
                              "\$57,543.00",
                              style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xff64748B),
                                  fontFamily: "Manrope-Medium"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppConstants.Height(10),
              Row(
                children: [
                  Text(
                    "Hot Bids",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Manrope-Bold",
                        color: notifier.textColor),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Hot_bids(),
                        ),
                      );
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Manrope-Medium",
                        color: Color(0xff6B39F4),
                      ),
                    ),
                  ),
                ],
              ),
              AppConstants.Height(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Collections(),
                          ),
                        );
                      },
                      child: Container(
                        height: height / 2.8,
                        width: width / 2.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                                color: notifier.getContainerBorder,
                                width: 1.5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, top: 5, right: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/images/Liquid.png",
                                  height: height / 5.3,
                                  width: width / 2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            AppConstants.Height(5),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 20),
                              child: Row(
                                children: [
                                  const Text(
                                    "Codexxx",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: "Manrope-SemiBold",
                                        color: Color(0xff64748B)),
                                  ),
                                  AppConstants.Width(3),
                                  Image.asset(
                                    "assets/images/verification.png",
                                    width: 12,
                                    height: 12,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Liquid Ruminations",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Manrope-SemiBold",
                                    color: notifier.textColor),
                              ),
                            ),
                            AppConstants.Height(10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: height / 13,
                                width: width / 2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: notifier.tabBar2),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, top: 13, right: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Price",
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Color(0xff64748B)),
                                          ),
                                          Spacer(),
                                          Text(
                                            "Current Bid",
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Color(0xff64748B)),
                                          )
                                        ],
                                      ),
                                    ),
                                    AppConstants.Height(5),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "0.029 ETH",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xff6B39F4),
                                                fontFamily: "Manrope-SemiBold"),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "0.019 ETH",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: notifier.textColor,
                                                fontFamily: "Manrope-SemiBold"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    AppConstants.Width(10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Collections(),
                          ),
                        );
                      },
                      child: Container(
                        height: height / 2.8,
                        width: width / 2.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: notifier.getContainerBorder, width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, top: 5, right: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/images/Genesis.png",
                                  height: height / 5.3,
                                  width: width / 2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            AppConstants.Height(5),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 20),
                              child: Row(
                                children: [
                                  const Text(
                                    "Nemus Genesis",
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontFamily: "Manrope-SemiBold",
                                        color: Color(0xff64748B)),
                                  ),
                                  AppConstants.Width(3),
                                  Image.asset(
                                    "assets/images/verification.png",
                                    width: 12,
                                    height: 12,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "Genesis Artikulugis",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Manrope-SemiBold",
                                    color: notifier.textColor),
                              ),
                            ),
                            AppConstants.Height(10),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: height / 13,
                                width: width / 2,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: notifier.tabBar2),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, top: 13, right: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Price",
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Color(0xff64748B)),
                                          ),
                                          Spacer(),
                                          Text(
                                            "Current Bid",
                                            style: TextStyle(
                                                fontSize: 9,
                                                color: Color(0xff64748B)),
                                          )
                                        ],
                                      ),
                                    ),
                                    AppConstants.Height(5),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10, bottom: 10),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "0.500 ETH",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Color(0xff6B39F4),
                                                fontFamily: "Manrope-SemiBold"),
                                          ),
                                          const Spacer(),
                                          Text(
                                            "0.450 ETH",
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: notifier.textColor,
                                                fontFamily: "Manrope-SemiBold"),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppConstants.Height(15),
              Row(
                children: [
                  Text(
                    "Top Collections",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Manrope-Bold",
                        color: notifier.textColor),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Top_collections_see(),
                        ),
                      );
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Manrope-Medium",
                        color: Color(0xff6B39F4),
                      ),
                    ),
                  ),
                ],
              ),
              AppConstants.Height(15),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Nemus(),
                    ),
                  );
                },
                child: Container(
                  height: height / 10,
                  // width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: notifier.getContainerBorder, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage("assets/images/Nemus.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nemus Genesis",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: notifier.textColor,
                                  ),
                                ),
                                AppConstants.Height(10),
                                const Text(
                                  "by Spacybox",
                                  style: TextStyle(
                                    color: Color(0xff64748B),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            AppConstants.Width(60),
                            Column(
                              children: [
                                Text(
                                  "\$217.3 ETH",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: notifier.textColor,
                                  ),
                                ),
                                AppConstants.Height(10),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/up-arrow.png",
                                      height: 10,
                                      width: 12,
                                    ),
                                    const Text(
                                      "53.9%",
                                      style: TextStyle(
                                        color: Color(0xff1DCE5C),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppConstants.Height(10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Spacy(),
                    ),
                  );
                },
                child: Container(
                  height: height / 10,
                  // width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: notifier.getContainerBorder,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/Stories.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Stories from...",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: notifier.textColor,
                                  ),
                                ),
                                AppConstants.Height(10),
                                const Text(
                                  "by Spacybox",
                                  style: TextStyle(
                                    color: Color(0xff64748B),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            AppConstants.Width(60),
                            Column(
                              children: [
                                Text(
                                  "\$453.00 ETH",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: notifier.textColor,
                                  ),
                                ),
                                AppConstants.Height(10),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/up-arrow.png",
                                      height: 10,
                                      width: 12,
                                    ),
                                    const Text(
                                      "60.9%",
                                      style: TextStyle(
                                        color: Color(0xff1DCE5C),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppConstants.Height(10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Statics(),
                    ),
                  );
                },
                child: Container(
                  height: height / 10,
                  // width: 360,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: notifier.getContainerBorder,
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Image(
                              image: AssetImage("assets/images/SOL.png"),
                              height: 40,
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Statics...",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: notifier.textColor,
                                  ),
                                ),
                                AppConstants.Height(10),
                                const Text(
                                  "by Spacybox",
                                  style: TextStyle(
                                    color: Color(0xff64748B),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            AppConstants.Width(60),
                            Column(
                              children: [
                                Text(
                                  "\$400.00 ETH",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: notifier.textColor,
                                  ),
                                ),
                                AppConstants.Height(10),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/up-arrow.png",
                                      height: 10,
                                      width: 12,
                                    ),
                                    const Text(
                                      "40.9%",
                                      style: TextStyle(
                                        color: Color(0xff1DCE5C),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
    );
  }
}
