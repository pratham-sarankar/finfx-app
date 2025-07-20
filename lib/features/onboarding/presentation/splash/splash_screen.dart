// Flutter imports:
import 'package:finfx/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:package_info_plus/package_info_plus.dart';

// Project imports:
import 'package:finfx/screens/Login%20Screens/login_screen.dart';
import 'package:finfx/services/auth_storage_service.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final AuthStorageService _authStorage = AuthStorageService();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        final isLoggedIn = await _authStorage.isLoggedIn();
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  isLoggedIn ? const HomeScreen() : const Login(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.sizeOf(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.surface,
              colorScheme.surfaceContainer,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Main content area
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // App Icon with container
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: colorScheme.primaryContainer,
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withValues(alpha: 0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Image(
                          image: const AssetImage(
                            "assets/images/app-icon.png",
                          ),
                          color: isDark ? Colors.white : null,
                          width: size.height * 0.15,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // App Name
                      Text(
                        "FinFX",
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontFamily: "Manrope-Bold",
                          fontSize: size.width * 0.08,
                          height: 1,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Tagline
                      Text(
                        "Where automation meets assurance",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Manrope-Regular",
                          color: colorScheme.onSurfaceVariant,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 48),
                      // Loading indicator
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Bottom section with version info
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: colorScheme.surfaceContainer,
                        border: Border.all(
                          color: colorScheme.outline.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.security,
                                size: 16,
                                color: colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Secure & Reliable",
                                style: TextStyle(
                                  color: colorScheme.primary,
                                  fontSize: 14,
                                  fontFamily: "Manrope-Bold",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          FutureBuilder<PackageInfo>(
                            future: PackageInfo.fromPlatform(),
                            builder: (context, snapshot) {
                              final version = snapshot.hasData
                                  ? 'Version ${snapshot.data!.version}'
                                  : 'Version ...';
                              return Text(
                                version,
                                style: TextStyle(
                                  color: colorScheme.onSurfaceVariant,
                                  fontSize: 12,
                                  fontFamily: "Manrope-Regular",
                                  letterSpacing: 0.3,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "© 2025 FinFX. All rights reserved.",
                      style: TextStyle(
                        color:
                            colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        fontSize: 11,
                        fontFamily: "Manrope-Regular",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
