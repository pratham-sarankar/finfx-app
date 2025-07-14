// ignore_for_file: file_names

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:finfx/screens/config/common.dart';

class Terms extends StatefulWidget {
  const Terms({super.key});

  @override
  State<Terms> createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Terms & Conditions",
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 20,
            fontFamily: "Manrope-Bold",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Terms & Conditions",
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontSize: 28,
                          fontFamily: "Manrope-Bold",
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: colorScheme.surface,
                          border: Border.all(
                            color: colorScheme.outline.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "Last update: 12 October 2022",
                          style: TextStyle(
                            color: colorScheme.onSurfaceVariant,
                            fontSize: 14,
                            fontFamily: "Manrope-Regular",
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        "The protection and confidentiality of your personal information is very important to us. Therefore, Financial Company with the website financial.com and the Financial mobile application (hereinafter referred to as \"Financial\") set the privacy policy as follows:",
                        style: TextStyle(
                          fontFamily: "Manrope-Regular",
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "Our Commitment",
                        content:
                            "We collect and use your personal information in accordance with the relevant provisions of the personal data protection law. This privacy policy describes the collection, use, storage and protection of your personal information. This applies to applications, all websites, sites and related services of the Financial regardless of how you access or use it.",
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "Scope and Approval",
                        content:
                            "You accept this privacy policy when you register, access, or use our products, services, content, features, technology or functions offered on the application, all websites, sites and related services (collectively called \"Financial Services\"). We can upload policy changes on this page periodically, the revised version will take effect on the effective date of publication. You are responsible for reviewing this privacy policy as often as possible.",
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "Data Collection",
                        content:
                            "We collect information that you provide directly to us, such as when you create an account, make a transaction, or contact us for support. This may include your name, email address, phone number, and other personal information necessary to provide our services.",
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "Data Usage",
                        content:
                            "We use the information we collect to provide, maintain, and improve our services, to process transactions, to communicate with you, and to comply with legal obligations. We do not sell your personal information to third parties.",
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "Data Security",
                        content:
                            "We implement appropriate security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet is 100% secure.",
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "Your Rights",
                        content:
                            "You have the right to access, correct, or delete your personal information. You may also have the right to restrict or object to certain processing of your information. Contact us to exercise these rights.",
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
                            color: colorScheme.primary.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: colorScheme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Important Notice",
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
                              "By using our services, you acknowledge that you have read and understood these terms and conditions. If you do not agree with any part of these terms, please do not use our services.",
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
            ],
          ),
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
