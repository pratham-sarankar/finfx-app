// Flutter imports:
import 'package:finfx/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:finfx/features/home/presentation/home_screen.dart';
import 'package:finfx/screens/Login%20Screens/Email%20verification.dart';
import 'package:finfx/services/auth_service.dart';
import 'package:finfx/services/auth_storage_service.dart';
import 'package:finfx/utils/api_error.dart';
import 'package:finfx/features/profile/presentation/providers/profile_provider.dart';

import '../../dark_mode.dart';
import '../config/common.dart';
import 'Forget pass.dart';
import 'Sign up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool value = false;
  bool _obsecuretext = true;
  bool _isLoading = false;
  late final AuthService _authService;
  final AuthStorageService _authStorage = AuthStorageService();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    _authService = context.read<AuthService>();
  }

  Future<void> _login() async {
    if (_isLoading) return;
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final formData = _formKey.currentState!.value;

      final email = formData['email'].toString().trim();
      final password = formData['password'].toString().trim();

      try {
        final response = await _authService.login(
          email,
          password,
        );
        final token = response['token'];

        await _authStorage.setToken(token);

        // Reload profile after successful login
        if (mounted) {
          await context.read<ProfileProvider>().fetchProfile(force: true);
        }

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      } on ApiError catch (e) {
        if (e.code == "email-not-verified") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmailVerification(
                email: email,
                password: password,
              ),
            ),
          );
          return;
        }
        if (mounted) {
          ToastUtils.showError(
            context: context,
            message: e.message,
          );
        }
      } catch (e) {
        if (mounted) {
          ToastUtils.showError(
            context: context,
            message: 'An unexpected error occurred. Please try again.',
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      ToastUtils.showInfo(
        context: context,
        message: 'Please fill in all required fields correctly.',
      );
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await _authService.loginWithGoogle();
      await _authStorage.setToken(response['token']);

      // Reload profile after successful Google login
      if (mounted) {
        await context.read<ProfileProvider>().fetchProfile(force: true);
      }

      if (mounted) {
        ToastUtils.showSuccess(
          context: context,
          message: 'Google login successful! Welcome back.',
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } on ApiError catch (e) {
      if (mounted) {
        ToastUtils.showError(
          context: context,
          message: e.message,
        );
      }
    } catch (e) {
      if (mounted) {
        ToastUtils.showError(
          context: context,
          message: 'An unexpected error occurred. Please try again.',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    var size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: colorScheme.surface,
        statusBarIconBrightness: colorScheme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                        height: height / 2.6,
                        width: width,
                        child: Column(
                          children: [
                            const Spacer(),
                            Image.asset(
                              "assets/images/app-icon.png",
                              color: colorScheme.primary,
                              height: height / 6,
                            ),
                            Text(
                              'Welcome Back!',
                              style: TextStyle(
                                color: colorScheme.primary,
                                fontSize: 24,
                                fontFamily: "Manrope-Bold",
                              ),
                            ),
                            Text(
                              'Sign in to your account',
                              style: TextStyle(
                                  color: colorScheme.primary
                                      .withValues(alpha: 0.7),
                                  fontSize: 18,
                                  fontFamily: "Manrope-Medium"),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        )),
                    AppConstants.Height(10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: [
                            AppConstants.Height(10),
                            FormBuilderTextField(
                              name: 'email',
                              style: TextStyle(color: colorScheme.onSurface),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "Email",
                                fillColor: colorScheme.surfaceContainer,
                                prefixIcon: Icon(IconlyLight.message),
                                prefixIconColor: colorScheme.onSurface
                                    .withValues(alpha: 0.6),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                hintStyle: TextStyle(
                                  color: colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                                errorStyle: TextStyle(
                                  color: colorScheme.error,
                                  fontSize: 12,
                                ),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Email is required'),
                                FormBuilderValidators.email(
                                    errorText: 'Please enter a valid email'),
                              ]),
                            ),
                            AppConstants.Height(15),
                            FormBuilderTextField(
                              name: 'password',
                              style: TextStyle(color: colorScheme.onSurface),
                              obscureText: _obsecuretext,
                              decoration: InputDecoration(
                                hintText: "Password",
                                fillColor: colorScheme.surfaceContainer,
                                prefixIcon: Icon(IconlyLight.lock),
                                prefixIconColor: colorScheme.onSurface
                                    .withValues(alpha: 0.6),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                hintStyle: TextStyle(
                                    color: colorScheme.onSurface
                                        .withValues(alpha: 0.6)),
                                errorStyle: TextStyle(
                                  color: colorScheme.error,
                                  fontSize: 12,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _obsecuretext = !_obsecuretext;
                                    });
                                  },
                                  icon: _obsecuretext
                                      ? const Icon(
                                          IconlyLight.show,
                                        )
                                      : const Icon(
                                          IconlyLight.hide,
                                        ),
                                ),
                                suffixIconColor: colorScheme.onSurface
                                    .withValues(alpha: 0.6),
                              ),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(
                                    errorText: 'Password is required'),
                                FormBuilderValidators.minLength(6,
                                    errorText:
                                        'Password must be at least 6 characters'),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              child: Row(
                                children: [
                                  Expanded(child: AppConstants.Width(60)),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Forget(),
                                          ));
                                    },
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: colorScheme.primary,
                                          fontFamily: "Manrope-Bold"),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            TextButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: colorScheme.onPrimary,
                                    fontSize: 15,
                                    fontFamily: "Manrope-Bold",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppConstants.Height(20),
                    Text(
                      "--------------- Or sign in with ---------------",
                      style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                          fontFamily: "Manrope-Medium"),
                    ),
                    AppConstants.Height(10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          side: BorderSide(color: colorScheme.outline),
                          minimumSize: Size(double.infinity, 56),
                        ),
                        onPressed: _loginWithGoogle,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage("assets/images/google.png"),
                              height: 19,
                              width: 16,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Google",
                              style: TextStyle(
                                color: colorScheme.onSurface,
                                fontFamily: "Manrope-SemiBold",
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    AppConstants.Height(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontFamily: "Manrope-Medium",
                              color:
                                  colorScheme.onSurface.withValues(alpha: 0.6)),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Sign(),
                                  ));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: colorScheme.primary,
                                  fontFamily: "Manrope-Bold"),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Loading Overlay
            if (_isLoading)
              Container(
                color: colorScheme.shadow.withValues(alpha: 0.5),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Signing in...',
                          style: TextStyle(
                            color: colorScheme.onSurface,
                            fontSize: 16,
                            fontFamily: "Manrope-Medium",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
