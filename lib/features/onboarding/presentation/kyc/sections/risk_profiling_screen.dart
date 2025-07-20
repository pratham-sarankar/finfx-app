// Flutter imports:
import 'package:finfx/utils/toast_utils.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:provider/provider.dart';

// Project imports:
import 'package:finfx/screens/config/common.dart';
import 'package:finfx/utils/api_error.dart';

import '../../providers/kyc_provider.dart';

class RiskProfilingScreen extends StatefulWidget {
  final VoidCallback onContinue;
  final String? selectedMonthlyIncome;
  final String? selectedCryptoPercentage;
  final String? selectedExperience;
  final String? selectedReaction;
  final String? selectedTimeframe;
  final bool? isAwareOfRegulation;
  final bool? isAwareOfRisks;
  final Function(String?) onMonthlyIncomeSelected;
  final Function(String?) onCryptoPercentageSelected;
  final Function(String?) onExperienceSelected;
  final Function(String?) onReactionSelected;
  final Function(String?) onTimeframeSelected;
  final Function(bool?) onRegulationAwarenessChanged;
  final Function(bool?) onRisksAwarenessChanged;

  const RiskProfilingScreen({
    super.key,
    required this.onContinue,
    required this.selectedMonthlyIncome,
    required this.selectedCryptoPercentage,
    required this.selectedExperience,
    required this.selectedReaction,
    required this.selectedTimeframe,
    required this.isAwareOfRegulation,
    required this.isAwareOfRisks,
    required this.onMonthlyIncomeSelected,
    required this.onCryptoPercentageSelected,
    required this.onExperienceSelected,
    required this.onReactionSelected,
    required this.onTimeframeSelected,
    required this.onRegulationAwarenessChanged,
    required this.onRisksAwarenessChanged,
  });

  @override
  State<RiskProfilingScreen> createState() => _RiskProfilingScreenState();
}

class _RiskProfilingScreenState extends State<RiskProfilingScreen> {
  bool _isSubmitting = false;

  Future<void> _handleSubmit() async {
    if (widget.selectedMonthlyIncome == null ||
        widget.selectedCryptoPercentage == null ||
        widget.selectedExperience == null ||
        widget.selectedReaction == null ||
        widget.selectedTimeframe == null ||
        widget.isAwareOfRegulation == null ||
        widget.isAwareOfRisks == null) {
      ToastUtils.showInfo(
        context: context,
        message: "Please answer all questions",
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      await context.read<KYCProvider>().submitRiskProfiling(
            monthlyIncome: widget.selectedMonthlyIncome!,
            cryptoPercentage: widget.selectedCryptoPercentage!,
            experience: widget.selectedExperience!,
            reaction: widget.selectedReaction!,
            timeframe: widget.selectedTimeframe!,
            isAwareOfRegulation: widget.isAwareOfRegulation!,
            isAwareOfRisks: widget.isAwareOfRisks!,
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
            "Risk Profiling",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Manrope-Bold",
              color: colorScheme.onSurface,
            ),
          ),
          AppConstants.Height(16),
          Text(
            "Help us understand your investment preferences and risk tolerance",
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurface.withValues(alpha: 0.6),
              fontFamily: "Manrope-Medium",
            ),
          ),
          AppConstants.Height(24),
          _buildQuestionSection(
            context,
            "What is your total monthly income?",
            [
              "Less than ₹50,000",
              "₹50,000–1,00,000",
              "₹1,00,001–2,00,000",
              "Above ₹2,00,000"
            ],
            widget.selectedMonthlyIncome,
            widget.onMonthlyIncomeSelected,
          ),
          AppConstants.Height(16),
          _buildQuestionSection(
            context,
            "What percentage of your wealth are you investing in crypto?",
            ["Less than 10%", "10–25%", "More than 25%"],
            widget.selectedCryptoPercentage,
            widget.onCryptoPercentageSelected,
          ),
          AppConstants.Height(16),
          _buildQuestionSection(
            context,
            "How would you rate your experience in crypto trading?",
            ["Beginner", "Intermediate", "Expert"],
            widget.selectedExperience,
            widget.onExperienceSelected,
          ),
          AppConstants.Height(16),
          _buildQuestionSection(
            context,
            "If your portfolio dropped 30% in one week, what would you do?",
            ["Panic and exit", "Hold and wait", "Invest more"],
            widget.selectedReaction,
            widget.onReactionSelected,
          ),
          AppConstants.Height(16),
          _buildQuestionSection(
            context,
            "How long can you stay invested without needing your capital?",
            [
              "Less than 6 months",
              "6–12 months",
              "1–3 years",
              "More than 3 years"
            ],
            widget.selectedTimeframe,
            widget.onTimeframeSelected,
          ),
          AppConstants.Height(16),
          _buildYesNoQuestion(
            context,
            "Are you aware that crypto markets are unregulated in India?",
            widget.isAwareOfRegulation,
            widget.onRegulationAwarenessChanged,
          ),
          AppConstants.Height(16),
          _buildYesNoQuestion(
            context,
            "Do you understand that automated trades may cause losses and are irreversible?",
            widget.isAwareOfRisks,
            widget.onRisksAwarenessChanged,
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
                    color: colorScheme.primary.withValues(alpha: 0.3),
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

  Widget _buildQuestionSection(
    BuildContext context,
    String question,
    List<String> options,
    String? selectedValue,
    Function(String?) onSelect,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Manrope-SemiBold",
            color: colorScheme.onSurface,
          ),
        ),
        AppConstants.Height(12),
        ...options.map((option) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _buildOptionTile(context, option, selectedValue == option,
                  () => onSelect(option)),
            )),
      ],
    );
  }

  Widget _buildOptionTile(BuildContext context, String option, bool isSelected,
      VoidCallback onTap) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.08)
              : colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? colorScheme.primary : colorScheme.outline,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Icon(
                        Icons.check,
                        size: 14,
                        color: colorScheme.primary,
                      ),
                    )
                  : null,
            ),
            AppConstants.Width(12),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  color:
                      isSelected ? colorScheme.primary : colorScheme.onSurface,
                  fontFamily: "Manrope-Medium",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYesNoQuestion(
    BuildContext context,
    String question,
    bool? value,
    Function(bool?) onChanged,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Manrope-SemiBold",
            color: colorScheme.onSurface,
          ),
        ),
        AppConstants.Height(12),
        Row(
          children: [
            Expanded(
              child: _buildYesNoOption(
                  context, "Yes", value == true, () => onChanged(true)),
            ),
            AppConstants.Width(16),
            Expanded(
              child: _buildYesNoOption(
                  context, "No", value == false, () => onChanged(false)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildYesNoOption(
      BuildContext context, String label, bool isSelected, VoidCallback onTap) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.08)
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
