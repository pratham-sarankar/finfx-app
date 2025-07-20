// ignore_for_file: file_names

// Dart imports:

// Flutter imports:
import 'package:finfx/utils/toast_utils.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import '../../services/auth_service.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  late final AuthService _authService;

  @override
  void initState() {
    super.initState();
    _authService = context.read<AuthService>();
  }

  Future<void> _sendForgotPasswordRequest(String email) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await _authService.forgotPassword(email);
      ToastUtils.showSuccess(context: context, message: response['message']);
    } catch (e) {
      ToastUtils.showError(
        context: context,
        message: 'Failed to send reset link',
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.close, color: colorScheme.onSurface, size: 25),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.05),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 27,
                    fontFamily: "Manrope-SemiBold",
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  "Enter your email to receive a password reset link.",
                  style: TextStyle(
                    fontSize: 16,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                    fontFamily: "Manrope-Medium",
                  ),
                ),
                SizedBox(height: height * 0.02),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    fillColor: colorScheme.surfaceContainer,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    hintStyle: TextStyle(
                        color: colorScheme.onSurface.withValues(alpha: 0.6)),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.02),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _sendForgotPasswordRequest(_emailController.text);
                    }
                  },
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
                    child: _isLoading
                        ? SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(
                              color: colorScheme.onPrimary,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "Send Reset Link",
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
      ),
    );
  }
}
