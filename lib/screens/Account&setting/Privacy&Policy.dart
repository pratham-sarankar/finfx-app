// ignore_for_file: file_names, camel_case_types

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:finfx/screens/config/common.dart';

class Policy extends StatefulWidget {
  const Policy({super.key});

  @override
  State<Policy> createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
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
          "Privacy Policy",
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 20,
            fontFamily: "Manrope-Bold",
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: colorScheme.onSurface,
            ),
            onPressed: () {
              // TODO: Implement menu functionality
            },
          ),
        ],
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
                    color: colorScheme.outline.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Privacy Policy",
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
                            color: colorScheme.outline.withOpacity(0.3),
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
                        title: "Information We Collect",
                        content:
                            "We collect information you provide directly to us, such as when you create an account, complete a profile, make transactions, or contact us for support. This may include your name, email address, phone number, date of birth, and financial information necessary to provide our services.",
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "How We Use Your Information",
                        content:
                            "We use the information we collect to provide, maintain, and improve our services, process transactions, communicate with you about your account, send you updates and marketing materials, and comply with legal obligations. We may also use your information for security purposes and to prevent fraud.",
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "Information Sharing",
                        content:
                            "We do not sell, trade, or otherwise transfer your personal information to third parties without your consent, except as described in this policy. We may share your information with service providers who assist us in operating our platform, processing transactions, or providing customer support.",
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "Data Security",
                        content:
                            "We implement appropriate technical and organizational security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction. These measures include encryption, secure servers, and regular security assessments.",
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "Data Retention",
                        content:
                            "We retain your personal information for as long as necessary to provide our services, comply with legal obligations, resolve disputes, and enforce our agreements. When we no longer need your information, we will securely delete or anonymize it.",
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "Your Privacy Rights",
                        content:
                            "You have the right to access, correct, update, or delete your personal information. You may also have the right to restrict processing, object to processing, or request data portability. To exercise these rights, please contact us through the app or our support channels.",
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 24),
                      _buildSection(
                        title: "Cookies and Tracking",
                        content:
                            "We use cookies and similar tracking technologies to enhance your experience, analyze usage patterns, and provide personalized content. You can control cookie settings through your browser preferences, though disabling cookies may affect some app functionality.",
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
                            color: colorScheme.primary.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.security,
                                  color: colorScheme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Your Privacy Matters",
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
                              "We are committed to protecting your privacy and ensuring the security of your personal information. If you have any questions about this privacy policy or our data practices, please contact our privacy team.",
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
