// Flutter imports:
import 'package:finfx/utils/toast_utils.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:finfx/utils/api_error.dart';
import '../../../../../screens/config/common.dart';
import '../../providers/kyc_provider.dart';

class BasicInfoScreen extends StatefulWidget {
  final VoidCallback onContinue;
  final TextEditingController fullNameController;
  final TextEditingController dobController;
  final TextEditingController panController;
  final TextEditingController aadhaarController;
  final String? selectedGender;
  final Function(String?) onGenderSelected;

  const BasicInfoScreen({
    super.key,
    required this.onContinue,
    required this.fullNameController,
    required this.dobController,
    required this.panController,
    required this.aadhaarController,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  State<BasicInfoScreen> createState() => _BasicInfoScreenState();
}

class _BasicInfoScreenState extends State<BasicInfoScreen> {
  bool _isSubmitting = false;

  Future<void> _handleSubmit() async {
    if (widget.fullNameController.text.isEmpty ||
        widget.dobController.text.isEmpty ||
        widget.selectedGender == null ||
        widget.panController.text.isEmpty) {
      ToastUtils.showInfo(
        context: context,
        message: "Please fill in all required fields",
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      // Parse the date from DD/MM/YYYY format to DateTime
      final dateParts = widget.dobController.text.split('/');
      final dob = DateTime(
        int.parse(dateParts[2]), // year
        int.parse(dateParts[1]), // month
        int.parse(dateParts[0]), // day
      );

      await context.read<KYCProvider>().submitBasicDetails(
            fullName: widget.fullNameController.text,
            dob: dob,
            gender: widget.selectedGender!,
            pan: widget.panController.text,
            aadharNumber: widget.aadhaarController.text.isEmpty
                ? null
                : widget.aadhaarController.text,
          );

      if (mounted) {
        widget.onContinue();
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
          message: "An unknown error occurred. Please try again later.",
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final kycProvider = context.watch<KYCProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Basic Information",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Manrope-Bold",
              color: colorScheme.onSurface,
            ),
          ),
          AppConstants.Height(16),
          Text(
            "Please provide your basic identification details for KYC verification",
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurface.withOpacity(0.6),
              fontFamily: "Manrope-Medium",
            ),
          ),
          AppConstants.Height(24),
          _buildTextField(
            context: context,
            controller: widget.fullNameController,
            label: "Full Name (as per PAN/Aadhaar)",
            hint: "Enter your full name",
          ),
          AppConstants.Height(16),
          _buildTextField(
            context: context,
            controller: widget.dobController,
            label: "Date of Birth",
            hint: "DD/MM/YYYY",
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: theme.copyWith(
                      colorScheme: colorScheme.copyWith(
                        primary: colorScheme.primary,
                        onPrimary: colorScheme.onPrimary,
                        surface: colorScheme.surface,
                        onSurface: colorScheme.onSurface,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                setState(() {
                  widget.dobController.text =
                      "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
                });
              }
            },
            readOnly: true,
          ),
          AppConstants.Height(16),
          _buildGenderSelector(context),
          AppConstants.Height(16),
          _buildTextField(
            context: context,
            controller: widget.panController,
            label: "PAN Number",
            hint: "Enter your PAN number",
          ),
          AppConstants.Height(16),
          _buildTextField(
            context: context,
            controller: widget.aadhaarController,
            label: "Aadhaar Number (Optional)",
            hint: "Enter your Aadhaar number",
          ),
          AppConstants.Height(24),
          GestureDetector(
            onTap:
                kycProvider.isLoading || _isSubmitting ? null : _handleSubmit,
            child: Container(
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: (kycProvider.isLoading || _isSubmitting)
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: colorScheme.onPrimary,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Manrope-SemiBold",
                          color: colorScheme.onPrimary,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    bool readOnly = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Manrope-SemiBold",
            color: colorScheme.onSurface,
          ),
        ),
        AppConstants.Height(8),
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            onTap: onTap,
            keyboardType: keyboardType,
            style: TextStyle(color: colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
            readOnly: readOnly,
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: TextStyle(
            fontSize: 14,
            fontFamily: "Manrope-SemiBold",
            color: colorScheme.onSurface,
          ),
        ),
        AppConstants.Height(8),
        Row(
          children: [
            Expanded(
              child: _buildGenderOption(context, "Male", "male"),
            ),
            AppConstants.Width(16),
            Expanded(
              child: _buildGenderOption(context, "Female", "female"),
            ),
            AppConstants.Width(16),
            Expanded(
              child: _buildGenderOption(context, "Other", "other"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = widget.selectedGender == value;
    return GestureDetector(
      onTap: () => widget.onGenderSelected(value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withOpacity(0.08)
              : colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? colorScheme.primary : colorScheme.onSurface,
              fontFamily: "Manrope-SemiBold",
            ),
          ),
        ),
      ),
    );
  }
}
