// ignore_for_file: file_names, camel_case_types

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:

class About_App extends StatefulWidget {
  const About_App({super.key});

  @override
  State<About_App> createState() => _About_AppState();
}

class _About_AppState extends State<About_App> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "About Us",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "Manrope-Bold",
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSection(
                            title: "Our Story",
                            content:
                                "At FinFX.Ai, we are passionate about reshaping the future of finance through intelligent automation and cutting-edge technology. Founded with a vision to empower traders and investors, we develop high-performance trading bots and tools that harness the power of AI, data analytics, and algorithmic precision.",
                            colorScheme: colorScheme,
                          ),
                          const SizedBox(height: 24),
                          _buildSection(
                            title: "Our Mission",
                            content:
                                "Our mission is to make crypto trading smarter, faster, and more accessible—whether you're a beginner or a seasoned professional. With a team of engineers, data scientists, and market analysts, FinFX.Ai is committed to delivering secure, transparent, and adaptive solutions for the evolving digital economy.",
                            colorScheme: colorScheme,
                          ),
                          const SizedBox(height: 24),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: colorScheme.primaryContainer,
                              border: Border.all(
                                color:
                                    colorScheme.primary.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.auto_awesome,
                                      color: colorScheme.primary,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Our Vision",
                                      style: TextStyle(
                                        color: colorScheme.primary,
                                        fontSize: 16,
                                        fontFamily: "Manrope-Bold",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "We're not just building software—we're building the future of autonomous trading.",
                                  style: TextStyle(
                                    color: colorScheme.onPrimaryContainer,
                                    fontSize: 14,
                                    fontFamily: "Manrope-Regular",
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Join Our Team Section
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
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: colorScheme.primaryContainer,
                            ),
                            child: Image.asset(
                              "assets/images/join team.png",
                              scale: 2.5,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Join Our Team",
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                    fontSize: 18,
                                    fontFamily: "Manrope-Bold",
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "We make investing accessible to more people and help them to reach their financial goals.",
                                  style: TextStyle(
                                    fontFamily: "Manrope-Regular",
                                    fontSize: 14,
                                    color: colorScheme.onSurfaceVariant,
                                    height: 1.5,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  height: 44,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // TODO: Implement join team functionality
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.primary,
                                      foregroundColor: colorScheme.onPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "Get Started",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Manrope-Bold",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    required ColorScheme colorScheme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 18,
            fontFamily: "Manrope-Bold",
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontFamily: "Manrope-Regular",
            fontSize: 14,
            color: colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
