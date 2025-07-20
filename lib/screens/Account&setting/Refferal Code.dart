// ignore_for_file: file_names, camel_case_types

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:

class Reffle_code extends StatefulWidget {
  const Reffle_code({super.key});

  @override
  State<Reffle_code> createState() => _Reffle_codeState();
}

class _Reffle_codeState extends State<Reffle_code> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Referral Program",
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Manrope-Bold",
            color: colorScheme.onSurface,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: colorScheme.surfaceContainer,
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: Image.asset(
                          "assets/images/Gift_1.png",
                          scale: 1.6,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Invite your friends and win up to 1 Million Dollar!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Manrope-Bold",
                          fontSize: 22,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Each time the friends you invite buy or sells, you get a 0.020%. Commission is calculated from the value of buy or sell purchase.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 14,
                          fontFamily: "Manrope-Regular",
                        ),
                      ),
                      const SizedBox(height: 32),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: colorScheme.outline.withValues(alpha: 0.3),
                            width: 1,
                          ),
                          color: colorScheme.surface,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Use @username as a referral code",
                              style: TextStyle(
                                color: colorScheme.onSurfaceVariant,
                                fontSize: 13,
                                fontFamily: "Manrope-Regular",
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  "@sample01",
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: colorScheme.onSurface,
                                    fontFamily: "Manrope-Bold",
                                  ),
                                ),
                                const Spacer(),
                                TextButton.icon(
                                  onPressed: () {
                                    // TODO: Implement copy functionality
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    color: colorScheme.primary,
                                    size: 16,
                                  ),
                                  label: Text(
                                    'Copy',
                                    style: TextStyle(
                                      color: colorScheme.primary,
                                      fontSize: 12,
                                      fontFamily: "Manrope-Bold",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                              ),
                              isScrollControlled: true,
                              backgroundColor: colorScheme.surface,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return Container(
                                      height: 500,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(24),
                                          topLeft: Radius.circular(24),
                                        ),
                                        color: colorScheme.surface,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Invite your friends",
                                                  style: TextStyle(
                                                    fontFamily: "Manrope-Bold",
                                                    fontSize: 20,
                                                    color:
                                                        colorScheme.onSurface,
                                                  ),
                                                ),
                                                const Spacer(),
                                                IconButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  icon: Icon(
                                                    Icons.close,
                                                    color:
                                                        colorScheme.onSurface,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              thickness: 1,
                                              color: colorScheme.outline
                                                  .withValues(alpha: 0.2),
                                            ),
                                            const SizedBox(height: 16),
                                            Container(
                                              height: 280,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: colorScheme.outline
                                                      .withValues(alpha: 0.3),
                                                ),
                                                color: colorScheme
                                                    .surfaceContainer,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  const SizedBox(height: 20),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20),
                                                    child: Text(
                                                      "John journeys",
                                                      style: TextStyle(
                                                        color: colorScheme
                                                            .onSurface,
                                                        fontSize: 17,
                                                        fontFamily:
                                                            "Manrope-Bold",
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20),
                                                    child: Text.rich(
                                                      TextSpan(
                                                        text: "I earned ",
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          fontFamily:
                                                              "Manrope-Bold",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: colorScheme
                                                              .onSurface,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text: "\$5 ",
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  "Manrope-Bold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: colorScheme
                                                                  .primary,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                " in assets by\nfinishing",
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  "Manrope-Bold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: colorScheme
                                                                  .onSurface,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: " 1 ",
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  "Manrope-Bold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: colorScheme
                                                                  .primary,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "lesson about",
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  "Manrope-Bold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: colorScheme
                                                                  .onSurface,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: " 4 ",
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  "Manrope-Bold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: colorScheme
                                                                  .primary,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                " investments",
                                                            style: TextStyle(
                                                              fontSize: 24,
                                                              fontFamily:
                                                                  "Manrope-Bold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: colorScheme
                                                                  .onSurface,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    height: 110,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomRight:
                                                            Radius.circular(16),
                                                        bottomLeft:
                                                            Radius.circular(16),
                                                      ),
                                                      color:
                                                          colorScheme.primary,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              20),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Use referral code and earn commission",
                                                            style: TextStyle(
                                                              color: colorScheme
                                                                  .onPrimary,
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  "Manrope-Regular",
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 16),
                                                          Container(
                                                            height: 45,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              color: colorScheme
                                                                  .surface,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                "@sample01",
                                                                style:
                                                                    TextStyle(
                                                                  color: colorScheme
                                                                      .onSurface,
                                                                  fontFamily:
                                                                      "Manrope-Medium",
                                                                  fontSize: 17,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 40),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                _buildShareButton(
                                                  icon: Icons.copy,
                                                  label: "Copy",
                                                  onTap: () {
                                                    // TODO: Implement copy functionality
                                                  },
                                                  colorScheme: colorScheme,
                                                ),
                                                _buildShareButton(
                                                  icon: Icons.share,
                                                  label: "WhatsApp",
                                                  onTap: () {
                                                    // TODO: Implement WhatsApp share
                                                  },
                                                  colorScheme: colorScheme,
                                                ),
                                                _buildShareButton(
                                                  icon: Icons.camera_alt,
                                                  label: "Instagram",
                                                  onTap: () {
                                                    // TODO: Implement Instagram share
                                                  },
                                                  colorScheme: colorScheme,
                                                ),
                                                _buildShareButton(
                                                  icon: Icons.more_horiz,
                                                  label: "More",
                                                  onTap: () {
                                                    // TODO: Implement more options
                                                  },
                                                  colorScheme: colorScheme,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.primary,
                            foregroundColor: colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Invite My Friends",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Manrope-Bold",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShareButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: colorScheme.surfaceContainer,
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(
              icon,
              size: 24,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface,
              fontFamily: "Manrope-Medium",
            ),
          ),
        ],
      ),
    );
  }
}
