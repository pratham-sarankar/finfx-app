// Flutter imports:
import 'package:finfx/utils/toast_utils.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

// Project imports:
import '../../services/auth_service.dart';
import '../../utils/api_error.dart';
import '../config/common.dart';
import 'Email verification.dart';
import 'login_screen.dart';

class Sign extends StatefulWidget {
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  bool _obsecuretext1 = true;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormBuilderState>();
  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = context.read<AuthService>();
  }

  // Function to handle sign-up
  Future<void> signUp() async {
    if (_isLoading) return;
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;

      // Check if terms are accepted
      if (formData['terms'] != true) {
        ToastUtils.showInfo(
          context: context,
          message: 'Please accept the terms and conditions to continue.',
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final response = await _authService.signUp(
          formData['fullName'].toString().trim(),
          formData['email'].toString().trim(),
          formData['password'].toString().trim(),
          formData['referralCode'],
        );

        if (mounted) {
          ToastUtils.showSuccess(
            context: context,
            message: response.message,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmailVerification(
                email: formData['email'].toString().trim(),
                password: formData['password'].toString().trim(),
              ),
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
    } else {
      ToastUtils.showInfo(
        context: context,
        message: 'Please fill in all required fields correctly.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.close,
            color: colorScheme.onSurface,
            size: 25,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppConstants.Height(20),
                    Text(
                      "Create your account",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Manrope-SemiBold",
                        color: colorScheme.onSurface,
                      ),
                    ),
                    AppConstants.Height(10),
                    Text(
                      "Let's get started with a free Financy account.",
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                        fontFamily: "Manrope-Medium",
                      ),
                    ),
                    AppConstants.Height(20),
                    FormBuilderTextField(
                      name: 'fullName',
                      style: TextStyle(color: colorScheme.onSurface),
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        fillColor: colorScheme.surfaceContainer,
                        filled: true,
                        prefixIcon: const Icon(IconlyLight.profile),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintStyle: TextStyle(
                            color:
                                colorScheme.onSurface.withValues(alpha: 0.6)),
                        errorStyle: TextStyle(
                          color: colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Full name is required',
                        ),
                        FormBuilderValidators.minLength(
                          2,
                          errorText: 'Name must be at least 2 characters',
                        ),
                      ]),
                    ),
                    AppConstants.Height(15),
                    FormBuilderTextField(
                      name: 'email',
                      style: TextStyle(color: colorScheme.onSurface),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
                        fillColor: colorScheme.surfaceContainer,
                        filled: true,
                        prefixIcon: const Icon(IconlyLight.message),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintStyle: TextStyle(
                            color:
                                colorScheme.onSurface.withValues(alpha: 0.6)),
                        errorStyle: TextStyle(
                          color: colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Email is required',
                        ),
                        FormBuilderValidators.email(
                          errorText: 'Please enter a valid email',
                        ),
                      ]),
                    ),
                    AppConstants.Height(15),
                    FormBuilderTextField(
                      name: 'password',
                      style: TextStyle(color: colorScheme.onSurface),
                      obscureText: _obsecuretext1,
                      decoration: InputDecoration(
                        hintText: "Password",
                        fillColor: colorScheme.surfaceContainer,
                        filled: true,
                        prefixIcon: const Icon(IconlyLight.lock),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintStyle: TextStyle(
                            color:
                                colorScheme.onSurface.withValues(alpha: 0.6)),
                        errorStyle: TextStyle(
                          color: colorScheme.error,
                          fontSize: 12,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obsecuretext1 = !_obsecuretext1;
                            });
                          },
                          icon: _obsecuretext1
                              ? const Icon(IconlyLight.show)
                              : const Icon(IconlyLight.hide),
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Password is required',
                        ),
                        FormBuilderValidators.minLength(
                          6,
                          errorText: 'Password must be at least 6 characters',
                        ),
                      ]),
                    ),
                    AppConstants.Height(20),
                    FormBuilderTextField(
                      name: 'referralCode',
                      style: TextStyle(color: colorScheme.onSurface),
                      decoration: InputDecoration(
                        hintText: "Referral Code",
                        fillColor: colorScheme.surfaceContainer,
                        filled: true,
                        prefixIcon: const Icon(IconlyLight.user_1),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintStyle: TextStyle(
                            color:
                                colorScheme.onSurface.withValues(alpha: 0.6)),
                        errorStyle: TextStyle(
                          color: colorScheme.error,
                          fontSize: 12,
                        ),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.equalLength(
                          8,
                          errorText: 'Invalid Referral Code',
                          allowEmpty: true,
                          checkNullOrEmpty: false,
                        ),
                      ]),
                    ),
                    AppConstants.Height(20),
                    FormBuilderCheckbox(
                      name: 'terms',
                      title: Text(
                        "I certify that I'm 18 years of age or older, and I agree to the User Agreement and Privacy Policy.",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Manrope-Medium",
                          color: colorScheme.onSurface,
                        ),
                      ),
                      activeColor: colorScheme.primary,
                      checkColor: colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: BorderSide(color: colorScheme.outline),
                      validator: FormBuilderValidators.equal(
                        true,
                        errorText: 'You must accept the terms to continue',
                      ),
                    ),
                    AppConstants.Height(20),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: signUp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontSize: 15,
                            fontFamily: "Manrope-Bold",
                          ),
                        ),
                      ),
                    ),
                    AppConstants.Height(20),
                    Center(
                      child: Text(
                        "--------------- Or sign in with ---------------",
                        style: TextStyle(
                          fontSize: 15,
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                          fontFamily: "Manrope-Medium",
                        ),
                      ),
                    ),
                    AppConstants.Height(10),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                          side: BorderSide(color: colorScheme.outline),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Image(
                              image: AssetImage("assets/images/google.png"),
                              height: 19,
                              width: 16,
                            ),
                            Text(
                              " Google",
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
                          "Already have an account?",
                          style: TextStyle(
                            fontFamily: "Manrope-Medium",
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Login(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.primary,
                              fontFamily: "Manrope-Medium",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
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
                        'Creating account...',
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
    );
  }
}
